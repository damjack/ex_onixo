defmodule ExOnixo.Parser.Product21.Illustration do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Illustrations"l)
    |> Enum.map(fn illustration ->
        %{
          illustration_type: RecordYml.get_tag21(illustration, "/illustrationType", "illustrationType")
        }
      end)
    |> Enum.to_list
  end
end
