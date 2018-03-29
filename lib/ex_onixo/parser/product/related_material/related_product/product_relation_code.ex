defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct.ProductRelationCode do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductRelationCode"l)
    |> Enum.map(fn product_relation_code ->
        %{
          text: RecordYml.get_tag(product_relation_code, "/", "ProductRelationCode"),
          code: product_relation_code |> xpath(~x"./text()"s)
        }
      end)
    |> Enum.to_list
  end
end
