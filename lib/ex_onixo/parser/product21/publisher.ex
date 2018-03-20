defmodule ExOnixo.Parser.Product21.Publisher do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Publisher"l)
    |> Enum.map(fn publisher ->
        %{
          publisher_role: RecordYml.get_human(publisher, %{tag: "/PublishingRole", codelist: "PublishingRole"}),
          name_code_type: publisher |> xpath(~x"./NameCodeType/text()"s),
          name_code_type_name: publisher |> xpath(~x"./NameCodeTypeName/text()"s),
          name_code_value: publisher |> xpath(~x"./NameCodeValue/text()"s),
          publisher_name: publisher |> xpath(~x"./PublisherName/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
