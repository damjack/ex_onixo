defmodule ExCatalogue.Parser.Product21.Language do
  import SweetXml
  alias ExCatalogue.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Language"l)
    |> Enum.map(fn language ->
        %{
            name_code: RecordYml.get_tag(language, "/LanguageCode", "LanguageCode"),
            name_text: xpath(language, ~x"./LanguageCode/text()"s),
            role_code: RecordYml.get_tag(language, "/LanguageRole", "LanguageRole"),
            role_text: xpath(language, ~x"./LanguageRole/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
