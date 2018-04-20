defmodule ExOnixo.Parser.Product.PublishingDetail.SalesRight.CountriesExcluded do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./CountriesExcluded"l)
    |> Enum.map(fn countries_excluded ->
        %{
          code: ElementYml.get_tag(countries_excluded, "/", "CountriesExcluded")
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
