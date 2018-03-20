defmodule ExOnixo.Parser.Product.Identifier do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductIdentifier"l)
    |> Enum.map(fn identifier ->
        %{
            product_id_type: RecordYml.get_human(identifier, %{tag: "/ProductIDType", codelist: "ProductIDType"}),
            id_value: identifier |> xpath(~x"./IDValue/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
