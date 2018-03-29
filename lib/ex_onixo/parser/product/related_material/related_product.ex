defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct.{
    RelatedProductIdentifier
  }

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedProduct"l)
    |> Enum.map(fn related_product ->
        %{
          text: RecordYml.get_tag(related_product, "/ProductRelationCode", "ProductRelationCode"),
          code: related_product |> xpath(~x"./ProductRelationCode/text()"s),
          product_form: RecordYml.get_tag(related_product, "/ProductForm", "ProductForm"),
          product_form_detail: RecordYml.get_tag(related_product, "/ProductFormDetail", "ProductFormDetail"),
          product_identifiers: RelatedProductIdentifier.parse_recursive(related_product)
        }
      end)
    |> Enum.to_list
  end
end
