defmodule ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail.TitleElement do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./TitleElement"l)
    |> Enum.map(fn title_element ->
        %{
            title_element_level: ElementYml.get_tag(title_element, "/TitleElementLevel", "TitleElementLevel"),
            part_number: xpath(title_element, ~x"./PartNumber/text()"s),
            title_text: xpath(title_element, ~x"./TitleText/text()"s)
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
