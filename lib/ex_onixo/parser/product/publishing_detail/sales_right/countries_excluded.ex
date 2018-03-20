defmodule ExOnixo.Parser.Product.PublishingDetail.SalesRight.CountriesExcluded do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./CountriesExcluded"l)
    |> Enum.map(fn countries_excluded ->
        %{
          code: RecordYml.get_human(countries_excluded, %{tag: "/", codelist: "CountriesExcluded"})
        }
      end)
    |> Enum.to_list
  end
end
