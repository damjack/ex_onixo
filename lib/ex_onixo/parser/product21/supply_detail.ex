defmodule ExOnixo.Parser.Product21.SupplyDetail do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SupplyDetail"l)
    |> Enum.map(fn supply_detail ->
        %{
          product_availability: ElementYml.get_tag21(supply_detail, "/ProductAvailability", "ProductAvailability"),
          date_format: xpath(supply_detail, ~x"./DateFormat/text()"s),
          supplier_name: xpath(supply_detail, ~x"./SupplierName/text()"s),
          on_sale_date: xpath(supply_detail, ~x"./OnSaleDate/text()"s),
        }
      end)
    |> Enum.to_list
  end
end
