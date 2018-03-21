defmodule ExOnixo.Parser.Product.RelatedMaterial.ProductRelationCode do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedProduct/ProductRelationCode"l)
    |> Enum.map(fn product_relation_code ->
        %{
          code: RecordYml.get_human(product_relation_code, %{tag: "/", codelist: "ProductRelationCode"}),
          text: product_relation_code |> xpath(~x"./text()"s)
        }
      end)
    |> Enum.to_list
  end
end
