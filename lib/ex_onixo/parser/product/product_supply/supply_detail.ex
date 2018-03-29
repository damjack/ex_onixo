defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.ProductSupply.SupplyDetail.{SupplierIdentifier, Website, Price}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SupplyDetail"l)
    |> Enum.map(fn supply_detail ->
        %{
            supplier_role: RecordYml.get_tag(supply_detail, "/Supplier/SupplierRole", "SupplierRole"),
            supplier_identifiers: SupplierIdentifier.parse_recursive(supply_detail),
            websites: Website.parse_recursive(supply_detail),
            product_availability_text: RecordYml.get_tag(supply_detail, "/ProductAvailability", "ProductAvailability"),
            product_availability_code: supply_detail |> xpath(~x"./ProductAvailability/text()"s),
            unpriced_item_type: RecordYml.get_tag(supply_detail, "/UnpricedItemType", "UnpricedItemType"),
            prices: Price.parse_recursive(supply_detail)
          }
      end)
    |> Enum.to_list
  end
end
