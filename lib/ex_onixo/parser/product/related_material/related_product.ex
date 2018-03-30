defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct do
  import SweetXml
  alias ExOnixo.Helper.ElementYml
  alias ExOnixo.Parser.Product.RelatedMaterial.RelatedProduct.{
    RelatedProductIdentifier
  }

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedProduct"l)
    |> Enum.map(fn related_product ->
        %{
          text: ElementYml.get_tag(related_product, "/ProductRelationCode", "ProductRelationCode"),
          code: xpath(related_product, ~x"./ProductRelationCode/text()"s),
          product_form: ElementYml.get_tag(related_product, "/ProductForm", "ProductForm"),
          product_form_detail: ElementYml.get_tag(related_product, "/ProductFormDetail", "ProductFormDetail"),
          product_identifiers: RelatedProductIdentifier.parse_recursive(related_product)
        }
      end)
    |> Enum.to_list
  end
end
