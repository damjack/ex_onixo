defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Price do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Price.Tax

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Price"l)
    |> Enum.map(fn price ->
        %{
            price_type: RecordYml.get_human(price, %{tag: "/PriceType", codelist: "PriceType"}),
            price_amount: price |> xpath(~x"./PriceAmount/text()"s),
            taxes: Tax.parse_recursive(price),
            countries_included: price |> xpath(~x"./Territory/CountriesIncluded/text()"s),
          }
      end)
    |> Enum.to_list
  end
end
