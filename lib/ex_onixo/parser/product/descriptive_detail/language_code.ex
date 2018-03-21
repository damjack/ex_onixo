defmodule ExOnixo.Parser.Product.DescriptiveDetail.LanguageCode do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Language/LanguageCode"l)
    |> Enum.map(fn language_code ->
        %{
            code: RecordYml.get_human(language_code, %{tag: "/", codelist: "LanguageCode"}),
            text: language_code |> xpath(~x"./text()"s)
          }
      end)
    |> Enum.to_list
  end
end
