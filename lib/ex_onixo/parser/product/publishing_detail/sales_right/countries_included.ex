defmodule ExOnixo.Parser.Product.PublishingDetail.SalesRight.CountriesIncluded do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./CountriesIncluded"l)
    |> Enum.map(fn countries_included ->
        %{
          code: RecordYml.get_human(countries_included, %{tag: "/", codelist: "CountriesIncluded"})
        }
      end)
    |> Enum.to_list
  end
end
