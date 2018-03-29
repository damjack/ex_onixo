defmodule ExOnixo.Parser.Product.CollateralDetail.TextContent do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./TextContent"l)
    |> Enum.map(fn text_content ->
        %{
          text_type: xpath(text_content, ~x"./TextType/text()"s),
          content_audience: xpath(text_content, ~x"./ContentAudience/text()"s),
          text: xpath(text_content, ~x"./Text/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
