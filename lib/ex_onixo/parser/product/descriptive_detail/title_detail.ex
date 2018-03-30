defmodule ExOnixo.Parser.Product.DescriptiveDetail.TitleDetail do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./TitleDetail"l)
    |> Enum.map(fn title_detail ->
        %{
            title_text: xpath(title_detail, ~x"./TitleElement/TitleText/text()"s),
            title_prefix: xpath(title_detail, ~x"./TitleElement/TitlePrefix/text()"s),
            title_without_prefix: xpath(title_detail, ~x"./TitleElement/TitleWithoutPrefix/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
