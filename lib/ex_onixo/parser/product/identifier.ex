defmodule ExOnixo.Parser.Product.Identifier do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductIdentifier"l)
    |> Enum.map(fn identifier ->
        %{
            product_id_type: ElementYml.get_tag(identifier, "/ProductIDType", "ProductIDType"),
            id_value: xpath(identifier, ~x"./IDValue/text()"s)
          }
      end)
    |> Enum.to_list
    |> handle_list
  end

  defp handle_list(nil), do: {:error, ""}
  defp handle_list(list), do: list
end
