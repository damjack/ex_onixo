defmodule ExOnixo.Parser.Product.RelatedMaterial do
  import SweetXml
  alias ExOnixo.Parser.Product.RelatedMaterial.{RelatedWorkIdentifier, RelatedProductIdentifier, ProductRelationCode, WorkRelationCode}

  def parse_recursive(xml) do
    related_materials =
      SweetXml.xpath(xml, ~x"./RelatedMaterial"l)
      |> Enum.map(fn related_material ->
          %{
            work_relation_codes: WorkRelationCode.parse_recursive(related_material),
            product_relation_codes: ProductRelationCode.parse_recursive(related_material),
            related_work_identifiers: RelatedWorkIdentifier.parse_recursive(related_material),
            related_product_identifiers: RelatedProductIdentifier.parse_recursive(related_material)
          }
        end)
      |> Enum.to_list
    unless Enum.empty?(related_materials) do
      Enum.fetch!(related_materials, 0)
    end
  end
end
