defmodule ExOnixo.Parser.Product21.Set.Identifier do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductIdentifier"l)
    |> Enum.map(fn identifier ->
        %{
          product_id_type: ElementYml.get_tag(identifier, "/ProductIDType", "ProductIDType"),
          id_type_name: xpath(identifier, ~x"./IDTypeName/text()"s),
          id_value: xpath(identifier, ~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
