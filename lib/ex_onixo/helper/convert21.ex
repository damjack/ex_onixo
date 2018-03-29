defmodule ExOnixo.Helper.Convert21 do
  @moduledoc false
  alias ExOnixo.Helper.{Identifier, Contributor, Category}

  defp title(list) do
    if String.length(list[:title_prefix]) !== 0 && String.length(list[:title_without_prefix]) !== 0 do
      "#{list[:title_prefix]} #{list[:title_without_prefix]}"
    else
      list[:title_text]
    end
  end

  defp description(list) do
    unless Enum.empty?(list) do
      list
        |> Enum.map(fn record ->
            if String.length(record[:text]) !== 0 do
              record[:text]
            end
          end)
        |> Enum.fetch!(0)
    end
  end

  defp covers(list) do
    if list do
      list
      |> Enum.map(fn file ->
        %{
            size: file[:media_file_type_code],
            date: file[:media_file_date],
            link: file[:media_file_link]
          }
        end)
      # |> Enum.reject(&is_nil/1)
      |> List.flatten
    end
  end

  defp publishing_status(code) do
    if code === "Active" do
      true
    else
      false
    end
  end

  def analyze(list) do
    %{
        record_reference: list[:record_reference],
        notification_type: list[:notification_type],
        isbn: Identifier.isbn(list[:product_identifiers]),
        ean: Identifier.ean(list[:product_identifiers]),
        title: title(list),
        contributors: Contributor.contributors(list[:contributors]),
        format: list[:product_form],
        pagesize: list[:number_of_pages],
        cce: Category.cce(list),
        publication_date: list[:publication_date],
        out_of_print_date: list[:out_of_print_date],
        publishing_status: publishing_status(list[:publishing_status]),
        description: description(list[:other_texts]),
        covers: covers(list[:media_files])
      }
  end
end
