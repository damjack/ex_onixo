defmodule ExOnixo.Parser.Product.RelatedMaterial.WorkRelationCode do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedWork/WorkRelationCode"l)
      |> Enum.map(fn work_relation_code ->
          %{
            code: ElementYml.get_tag(work_relation_code, "/", "WorkRelationCode"),
            text: xpath(work_relation_code, ~x"./text()"s)
          }
        end)
      |> Enum.to_list
      |> handle_list
  end

  defp handle_list(nil), do: {:error, ""}
  defp handle_list([]), do: {:error, ""}
  defp handle_list(list) do
    List.first(list)
  end
end
