defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedProductIdentifier do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedProduct/ProductIdentifier"l)
    |> Enum.map(fn related_product_identifier ->
        %{
          product_id_type: RecordYml.get_human(related_product_identifier, %{tag: "/ProductIDType", codelist: "ProductIDType"}),
          id_value: related_product_identifier |> xpath(~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
