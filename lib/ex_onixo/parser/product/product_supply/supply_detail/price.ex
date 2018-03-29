defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Price do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Price.Tax

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Price"l)
    |> Enum.map(fn price ->
        %{
            price_type: RecordYml.get_tag(price, "/PriceType", "PriceType"),
            price_amount: xpath(price, ~x"./PriceAmount/text()"s),
            taxes: Tax.parse_recursive(price),
            countries_included: xpath(price, ~x"./Territory/CountriesIncluded/text()"s),
          }
      end)
    |> Enum.to_list
  end
end
