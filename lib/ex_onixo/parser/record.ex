defmodule ExOnixo.Parser.Record do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.{Identifier, DescriptiveDetail, CollateralDetail, PublishingDetail, RelatedMaterial, ProductSupply}

  def parse_recursive(xml) do
    product = SweetXml.xpath(xml, ~x"//Product")
    %{
        record_reference: product |> xpath(~x"./RecordReference/text()"s),
        notification_type: RecordYml.get_human(product, %{tag: "/NotificationType", codelist: "NotificationType"}),
        product_identifiers: Identifier.parse_recursive(product),
        descriptive_details: DescriptiveDetail.parse_recursive(product),
        collateral_details: CollateralDetail.parse_recursive(product),
        publishing_details: PublishingDetail.parse_recursive(product),
        related_materials: RelatedMaterial.parse_recursive(product),
        product_supplies: ProductSupply.parse_recursive(product)
      }
  end
end
