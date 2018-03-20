defmodule ExOnixo.Parser.Product21.OtherText do
  import SweetXml
  alias ExOnixo.Parser.RecordYml21

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./OtherText"l)
    |> Enum.map(fn other_text ->
        %{
          text_type_code: RecordYml21.get_human(other_text, %{tag: "/TextTypeCode", codelist: "TextTypeCode"}),
          text_format: RecordYml21.get_human(other_text, %{tag: "/TextFormat", codelist: "TextFormat"}),
          text: other_text |> xpath(~x"./Text/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
