defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.ProductSupply.SupplyDetail.{SupplierIdentifier, Website, Price}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SupplyDetail"l)
    |> Enum.map(fn supply_detail ->
        %{
            supplier_role: RecordYml.get_human(supply_detail, %{tag: "/Supplier/SupplierRole", codelist: "SupplierRole"}),
            supplier_identifiers: SupplierIdentifier.parse_recursive(supply_detail),
            websites: Website.parse_recursive(supply_detail),
            product_availability: supply_detail |> xpath(~x"./ProductAvailability/text()"s),
            unpriced_item_type: RecordYml.get_human(supply_detail, %{tag: "/UnpricedItemType", codelist: "UnpricedItemType"}),
            prices: Price.parse_recursive(supply_detail)
          }
      end)
    |> Enum.to_list
  end
end
