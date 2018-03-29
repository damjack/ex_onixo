defmodule ExOnixo.Parser.Product.PublishingDetail.SalesRight.CountriesExcluded do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./CountriesExcluded"l)
    |> Enum.map(fn countries_excluded ->
        %{
          code: RecordYml.get_tag(countries_excluded, "/", "CountriesExcluded")
        }
      end)
    |> Enum.to_list
  end
end
