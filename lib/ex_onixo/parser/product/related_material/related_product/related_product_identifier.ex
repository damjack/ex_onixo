defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct.RelatedProductIdentifier do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductIdentifier"l)
    |> Enum.map(fn related_product_identifier ->
        %{
          product_id_type: ElementYml.get_tag(related_product_identifier, "/ProductIDType", "ProductIDType"),
          id_value: xpath(related_product_identifier, ~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
