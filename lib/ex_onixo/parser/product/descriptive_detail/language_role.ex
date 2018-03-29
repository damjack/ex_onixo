defmodule ExOnixo.Parser.Product.DescriptiveDetail.LanguageRole do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Language/LanguageRole"l)
    |> Enum.map(fn language_role ->
        %{
            code: RecordYml.get_tag(language_role, "/", "LanguageRole"),
            text: language_role |> xpath(~x"./text()"s)
          }
      end)
    |> Enum.to_list
  end
end
