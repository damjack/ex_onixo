defmodule ExOnixo.Parser.Product.DescriptiveDetail.Extent do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Extent"l)
    |> Enum.map(fn extent ->
        %{
            type: RecordYml.get_human(extent, %{tag: "/ExtentType", codelist: "ExtentType"}),
            value: extent |> xpath(~x"./ExtentValue/text()"s),
            unit: RecordYml.get_human(extent, %{tag: "/ExtentUnit", codelist: "ExtentUnit"})
          }
      end)
    |> Enum.to_list
  end
end
