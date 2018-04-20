defmodule ExOnixo.Parser.Product.DescriptiveDetail.Extent do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Extent"l)
    |> Enum.map(fn extent ->
        %{
            type: ElementYml.get_tag(extent, "/ExtentType", "ExtentType"),
            value: xpath(extent, ~x"./ExtentValue/text()"s),
            unit: ElementYml.get_tag(extent, "/ExtentUnit", "ExtentUnit")
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
