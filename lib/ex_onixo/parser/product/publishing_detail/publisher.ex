defmodule ExOnixo.Parser.Product.PublishingDetail.Publisher do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Publisher"l)
    |> Enum.map(fn publisher ->
        %{
          code_role: publisher |> xpath(~x"./PublishingRole/text()"s),
          text_role: RecordYml.get_tag(publisher, "/PublishingRole", "PublishingRole"),
          name: publisher |> xpath(~x"./PublisherName/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
