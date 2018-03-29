defmodule ExOnixo.Parser.Product21.SupplyDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SupplyDetail"l)
    |> Enum.map(fn supply_detail ->
        %{
          product_availability: RecordYml.get_tag21(supply_detail, "/ProductAvailability", "ProductAvailability"),
          date_format: supply_detail |> xpath(~x"./DateFormat/text()"s),
          supplier_name: supply_detail |> xpath(~x"./SupplierName/text()"s),
          on_sale_date: supply_detail |> xpath(~x"./OnSaleDate/text()"s),
        }
      end)
    |> Enum.to_list
  end
end
