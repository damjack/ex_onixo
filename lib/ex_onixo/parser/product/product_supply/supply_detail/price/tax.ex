defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Price.Tax do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Tax"l)
    |> Enum.map(fn tax ->
        %{
            tax_type: ElementYml.get_tag(tax, "/TaxType", "TaxType"),
            tax_rate_code: ElementYml.get_tag(tax, "/TaxRateCode", "TaxRateCode"),
            tax_rate_percent: xpath(tax, ~x"./TaxRatePercent/text()"s),
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
