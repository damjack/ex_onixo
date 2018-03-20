defmodule ExOnixo.Parser.Product.CollateralDetail.TextContent do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./TextContent"l)
    |> Enum.map(fn text_content ->
        %{
          text_type: text_content |> xpath(~x"./TextType/text()"s),
          content_audience: text_content |> xpath(~x"./ContentAudience/text()"s),
          text: text_content |> xpath(~x"./Text/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
