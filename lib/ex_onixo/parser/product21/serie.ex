defmodule ExOnixo.Parser.Product21.Serie do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Series"l)
    |> Enum.map(fn serie ->
        %{
          id_type: ElementYml.get_tag21(serie, "/SeriesIdentifier/SeriesIDType", "SeriesIDType"),
          id_value: xpath(serie, ~x"./SeriesIdentifier/IDValue/text()"s),
          title_of_series: xpath(serie, ~x"./TitleOfSeries/text()"s),
          number_within_series: xpath(serie, ~x"./NumberWithinSeries/text()"s),
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
