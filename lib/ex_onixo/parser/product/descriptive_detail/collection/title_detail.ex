defmodule ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail.TitleElement

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./TitleDetail"l)
    |> Enum.map(fn title_detail ->
        %{
            title_type: RecordYml.get_human(title_detail, %{tag: "/TitleType", codelist: "TitleType"}),
            title_element: TitleElement.parse_recursive(title_detail)
          }
      end)
    |> Enum.to_list
  end
end
