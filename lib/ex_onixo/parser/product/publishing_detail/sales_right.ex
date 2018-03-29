defmodule ExOnixo.Parser.Product.PublishingDetail.SalesRight do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.PublishingDetail.SalesRight.{CountriesIncluded, CountriesExcluded}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SalesRight"l)
    |> Enum.map(fn sales_right ->
        %{
          sales_right_type: RecordYml.get_tag(sales_right, "/SalesRightsType", "SalesRightsType"),
          countries_included: CountriesIncluded.parse_recursive(sales_right),
          countries_excluded: CountriesExcluded.parse_recursive(sales_right)
        }
      end)
    |> Enum.to_list
  end
end
