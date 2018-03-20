defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Price.Tax do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Tax"l)
    |> Enum.map(fn tax ->
        %{
            tax_type: RecordYml.get_human(tax, %{tag: "/TaxType", codelist: "TaxType"}),
            tax_rate_code: RecordYml.get_human(tax, %{tag: "/TaxRateCode", codelist: "TaxRateCode"}),
            tax_rate_percent: tax |> xpath(~x"./TaxRatePercent/text()"s),
          }
      end)
    |> Enum.to_list
  end
end
