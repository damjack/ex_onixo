defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedWorkIdentifier do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedWork/WorkIdentifier"l)
    |> Enum.map(fn related_work_identifier ->
        %{
          work_id_type: ElementYml.get_tag(related_work_identifier, "/WorkIDType", "WorkIDType"),
          id_value: xpath(related_work_identifier, ~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
