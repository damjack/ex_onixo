defmodule ExOnixo.Parser.Product21.OtherText do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./OtherText"l)
    |> Enum.map(fn other_text ->
        %{
          text_type_code: RecordYml.get_tag21(other_text, "/TextTypeCode", "TextTypeCode"),
          text_format: RecordYml.get_tag21(other_text, "/TextFormat", "TextFormat"),
          text: other_text |> xpath(~x"./Text/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
