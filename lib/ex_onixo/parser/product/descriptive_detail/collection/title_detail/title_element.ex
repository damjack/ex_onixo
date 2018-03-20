defmodule ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail.TitleElement do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./TitleElement"l)
    |> Enum.map(fn title_element ->
        %{
            title_element_level: RecordYml.get_human(title_element, %{tag: "/TitleElementLevel", codelist: "TitleElementLevel"}),
            part_number: title_element |> xpath(~x"./PartNumber/text()"s),
            title_text: title_element |> xpath(~x"./TitleText/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
