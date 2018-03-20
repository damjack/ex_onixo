defmodule ExOnixo.Parser.Product.RelatedMaterial do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.RelatedMaterial.{RelatedWorkIdentifier, RelatedProductIdentifier}

  def parse_recursive(xml) do
    related_materials =
      SweetXml.xpath(xml, ~x"./RelatedMaterial"l)
      |> Enum.map(fn related_material ->
          %{
            work_relation_code: RecordYml.get_human(related_material, %{tag: "/RelatedWork/WorkRelationCode", codelist: "WorkRelationCode"}),
            product_relation_code: RecordYml.get_human(related_material, %{tag: "/RelatedProduct/ProductRelationCode", codelist: "ProductRelationCode"}),
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
