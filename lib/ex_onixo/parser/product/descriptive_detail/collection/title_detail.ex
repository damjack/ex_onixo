defmodule ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail do
  import SweetXml
  alias ExOnixo.Helper.ElementYml
  alias ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail.TitleElement

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./TitleDetail"l)
    |> Enum.map(fn title_detail ->
        %{
            title_type: ElementYml.get_tag(title_detail, "/TitleType", "TitleType"),
            title_element: TitleElement.parse_recursive(title_detail)
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
