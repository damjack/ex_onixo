defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct.ProductRelationCode do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductRelationCode"l)
    |> Enum.map(fn product_relation_code ->
        %{
          text: ElementYml.get_tag(product_relation_code, "/", "ProductRelationCode"),
          code: xpath(product_relation_code, ~x"./text()"s)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
