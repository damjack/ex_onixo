defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct.RelatedProductIdentifier do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductIdentifier"l)
    |> Enum.map(fn related_product_identifier ->
        %{
          product_id_type: RecordYml.get_tag(related_product_identifier, "/ProductIDType", "ProductIDType"),
          id_value: related_product_identifier |> xpath(~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
