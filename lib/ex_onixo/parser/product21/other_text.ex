defmodule ExOnixo.Parser.Product21.OtherText do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./OtherText"l)
    |> Enum.map(fn other_text ->
        %{
          text_type_code: ElementYml.get_tag21(other_text, "/TextTypeCode", "TextTypeCode"),
          text_format: ElementYml.get_tag21(other_text, "/TextFormat", "TextFormat"),
          text: xpath(other_text, ~x"./Text/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
