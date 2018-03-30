defmodule ExOnixo.Parser.Product.PublishingDetail.SalesRight.CountriesIncluded do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./CountriesIncluded"l)
    |> Enum.map(fn countries_included ->
        %{
          code: ElementYml.get_tag(countries_included, "/", "CountriesIncluded")
        }
      end)
    |> Enum.to_list
  end
end
