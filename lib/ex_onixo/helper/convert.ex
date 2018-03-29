defmodule ExOnixo.Helper.Convert do
  @moduledoc false
  alias ExOnixo.Helper.{Identifier, Contributor, Category}

  defp drm(list) do
    list[:epub_technical_protection]
  end

  defp language(list) do
    if !Enum.empty?(list[:language_codes]) do
      res = list[:language_codes]
        |> Enum.map(fn record ->
            record[:text]
          end)
        |> Enum.reject(&is_nil/1)
      if Enum.count(res) !== 0 do
        Enum.fetch!(res, 0)
      end
    end
  end

  defp format(list) do
    if list && Map.has_key?(list, :product_form_details) do
      unless Enum.empty?(list[:product_form_details]) do
        list[:product_form_details]
        |> Enum.map(fn record ->
            record[:text]
          end)
        |> Enum.fetch!(0)
      end
    end
  end

  defp title(list) do
    list[:title_details]
    |> Enum.map(fn record ->
        if String.length(record[:title_prefix]) !== 0 && String.length(record[:title_without_prefix]) !== 0 do
          "#{record[:title_prefix]} #{record[:title_without_prefix]}"
        else
          record[:title_text]
        end
      end)
    |> Enum.fetch!(0)
  end

  defp description(list) do
    if list do
      unless Enum.empty?(list[:text_contents]) do
        list[:text_contents]
        |> Enum.map(fn record ->
            if String.length(record[:text]) !== 0 do
              record[:text]
            end
          end)
        |> Enum.fetch!(0)
      end
    end
  end

  defp covers(list) do
    if list do
      list[:supporting_resources]
      |> Enum.map(fn support ->
          if support[:resource_content_type] === "FrontCover" do
            Enum.map(support[:resource_versions], fn version ->
              %{
                  link: version[:resource_link]
                }
              end)
            |> Enum.to_list
          end
        end)
      # |> Enum.reject(&is_nil/1)
      |> List.flatten
    end
  end

  defp publishing_date(nil), do: nil
  defp publishing_date(list) do
    publishing_date_list(list[:publishing_date])
  end

  defp publishing_date_list(nil), do: nil
  defp publishing_date_list(list) do
    list
    |> Enum.map(fn publishing_date ->
        if publishing_date[:role] === "PublicationDate" do
          publishing_date[:date]
        end
      end)
    |> Enum.reject(&is_nil/1)
    |> handle_publishing_date_list
  end

  defp handle_publishing_date_list(nil), do: nil
  defp handle_publishing_date_list(map) do
    List.first(map)
  end

  defp publishing_status(list) do
    if list[:publishing_status] === "Active" do
      true
    else
      false
    end
  end

  defp related_isbn(list) do
    if list && Map.has_key?(list, :related_products) do
      unless Enum.empty?(list[:related_products]) do
        list[:related_products]
        |> Enum.map(fn rel ->
            if rel[:text] == "AlternativeFormat" do
              rel[:product_identifiers]
              |> Enum.map(fn pi ->
                  if pi[:product_id_type] === "Isbn13" || pi[:product_id_type] === "Gtin13" do
                    pi[:id_value]
                  end
                end)
              |> Enum.reject(&is_nil/1)
            end
          end)
        |> List.flatten
        |> Enum.reject(&is_nil/1)
        |> Enum.to_list
      end
    end
  end

  defp printed_isbn(list) do
    if list && Map.has_key?(list, :related_products) do
      unless Enum.empty?(list[:related_products]) do
        res =
          list[:related_products]
            |> Enum.map(fn rel ->
                if rel[:text] == "EpublicationBasedOnPrintProduct" do
                  rel[:product_identifiers]
                  |> Enum.map(fn pi ->
                      if pi[:product_id_type] === "Isbn13" || pi[:product_id_type] === "Gtin13" do
                        pi[:id_value]
                      end
                    end)
                  |> Enum.reject(&is_nil/1)
                end
              end)
            |> List.flatten
            |> Enum.reject(&is_nil/1)
        if res && !Enum.empty?(res) do
          Enum.fetch!(res, 0)
        end
      end
    end
  end

  defp related_identifiers(list) do
    if list && Map.has_key?(list, :related_products) do
      unless Enum.empty?(list[:related_products]) do
        list[:related_products]
        |> Enum.map(fn rel ->
            rel[:product_identifiers]
            |> Enum.map(fn pi ->
                pi[:product_id_type]
              end)
            |> Enum.reject(&is_nil/1)
          end)
        |> List.flatten
        |> Enum.reject(&is_nil/1)
        |> Enum.to_list
      end
    end
  end

  defp pagesize(list) do
    res = list[:extents]
    |> Enum.map(fn extent ->
        if extent[:type] === "NumberOfPagesInPrintCounterpart" || extent[:type] === "AbsolutePageCount" do
          extent[:value]
        end
      end)
    |> Enum.reject(&is_nil/1)
    if Enum.count(res) !== 0 do
      Enum.fetch!(res, 0)
      |> String.to_integer
    end
  end

  defp filesize(list) do
    res = list[:extents]
    |> Enum.map(fn extent ->
        if extent[:type] === "Filesize" do
          extent[:value]
        end
      end)
    |> Enum.reject(&is_nil/1)
    if Enum.count(res) !== 0 do
      Enum.fetch!(res, 0)
    end
  end

  defp filesize_unit(list) do
    res = list[:extents]
    |> Enum.map(fn extent ->
        if extent[:type] === "Filesize" do
          extent[:unit]
        end
      end)
    |> Enum.reject(&is_nil/1)
    if Enum.count(res) !== 0 do
      Enum.fetch!(res, 0)
    end
  end

  def product_availability(list) do
    if list do
      list
      |> Enum.map(fn l ->
          l[:supply_details]
          |> Enum.map(fn sd ->
              if available(sd[:product_availability_text]) do
                true
              else
                false
              end
            end)
          |> Enum.reject(&is_nil/1)
        end)
        |> List.flatten
        |> Enum.reject(&is_nil/1)
        |> Enum.fetch!(0)
    end
  end

  defp available(code), do: code in ["Available", "InStock", "ToOrder", "NotYetAvailable", "Pod"]

  def publisher(list) do
    if list && Map.has_key?(list, :publishers) do
      unless Enum.empty?(list[:publishers]) do
        list[:publishers]
        |> Enum.map(fn pub ->
            if pub[:code_role] === "01" do
              %{
                  name: pub[:name],
                  code_role: pub[:code_role],
                  text_role: pub[:text_role]
                }
            end
          end)
        |> Enum.reject(&is_nil/1)
        |> Enum.fetch!(0)
      end
    end
  end

  def analyze(list) do
    %{
        record_reference: list[:record_reference],
        notification_type: list[:notification_type],
        isbn: Identifier.isbn(list[:product_identifiers]),
        ean: Identifier.ean(list[:product_identifiers]),
        title: title(list[:descriptive_details]),
        contributors: Contributor.contributors(list[:descriptive_details][:contributors]),
        drm: drm(list[:descriptive_details]),
        language: language(list[:descriptive_details]),
        format: format(list[:descriptive_details]),
        filesize: filesize(list[:descriptive_details]),
        filesize_unit: filesize_unit(list[:descriptive_details]),
        pagesize: pagesize(list[:descriptive_details]),
        cce: Category.cce(list[:descriptive_details]),
        publishing_date: publishing_date(list[:publishing_details]),
        publishing_status: publishing_status(list[:publishing_details]),
        product_availability: product_availability(list[:product_supplies]),
        publisher: publisher(list[:publishing_details]),
        related_isbn: related_isbn(list[:related_materials]),
        printed_isbn: printed_isbn(list[:related_materials]),
        description: description(list[:collateral_details]),
        covers: covers(list[:collateral_details]),
        related_identifiers: related_identifiers(list[:related_materials])
      }
  end
end
