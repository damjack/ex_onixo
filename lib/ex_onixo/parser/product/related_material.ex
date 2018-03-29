defmodule ExOnixo.Parser.Product.RelatedMaterial do
  import SweetXml
  alias ExOnixo.Parser.Product.RelatedMaterial.{
    RelatedWorkIdentifier,
    RelatedProduct,
    WorkRelationCode
  }

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedMaterial"l)
      |> Enum.map(fn related_material ->
          %{
            work_relation_codes: WorkRelationCode.parse_recursive(related_material),
            related_work_identifiers: RelatedWorkIdentifier.parse_recursive(related_material),
            related_products: RelatedProduct.parse_recursive(related_material)
          }
        end)
      |> Enum.to_list
      |> handle_list
  end

  defp handle_list(nil), do: nil
  defp handle_list([]), do: nil
  defp handle_list(list) do
    List.first(list)
  end
end
