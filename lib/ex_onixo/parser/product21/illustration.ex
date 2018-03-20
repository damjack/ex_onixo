defmodule ExOnixo.Parser.Product21.Illustration do
  import SweetXml
  alias ExOnixo.Parser.RecordYml21

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Illustrations"l)
    |> Enum.map(fn illustration ->
        %{
          illustration_type: RecordYml21.get_human(illustration, %{tag: "/illustrationType", codelist: "illustrationType"})
        }
      end)
    |> Enum.to_list
  end
end
