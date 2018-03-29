defmodule ExOnixo.Parser.Product.Identifier do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductIdentifier"l)
    |> Enum.map(fn identifier ->
        %{
            product_id_type: RecordYml.get_tag(identifier, "/ProductIDType", "ProductIDType"),
            id_value: xpath(identifier, ~x"./IDValue/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
