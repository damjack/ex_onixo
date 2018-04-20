defmodule ExOnixo.Parser.Product do
  import SweetXml
  alias ExOnixo.Helper.ElementYml
  alias ExOnixo.Parser.Product.{
    Identifier,
    DescriptiveDetail,
    CollateralDetail,
    PublishingDetail,
    RelatedMaterial,
    ProductSupply
  }

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"//Product")
      |> to_map
  end

  defp to_map(xml) do
    %{
        record_reference: xpath(xml, ~x"./RecordReference/text()"s),
        notification_type: ElementYml.get_tag(xml, "/NotificationType", "NotificationType"),
        product_identifiers: Identifier.parse_recursive(xml),
        descriptive_details: DescriptiveDetail.parse_recursive(xml),
        collateral_details: CollateralDetail.parse_recursive(xml),
        publishing_details: PublishingDetail.parse_recursive(xml),
        related_materials: RelatedMaterial.parse_recursive(xml),
        product_supplies: ProductSupply.parse_recursive(xml)
      }
  end
end
