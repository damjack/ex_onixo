defmodule ExOnixo.Parser.Product21.Serie do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Series"l)
    |> Enum.map(fn serie ->
        %{
          id_type: RecordYml.get_tag21(serie, "/SeriesIdentifier/SeriesIDType", "SeriesIDType"),
          id_value: serie |> xpath(~x"./SeriesIdentifier/IDValue/text()"s),
          title_of_series: serie |> xpath(~x"./TitleOfSeries/text()"s),
          number_within_series: serie |> xpath(~x"./NumberWithinSeries/text()"s),
        }
      end)
    |> Enum.to_list
  end
end
