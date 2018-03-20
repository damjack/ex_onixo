defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.SupplierIdentifier do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Supplier/SupplierIdentifier"l)
    |> Enum.map(fn supplier_identifier ->
        %{
          supplier_id_type: RecordYml.get_human(supplier_identifier, %{tag: "/SupplierIDType", codelist: "SupplierIDType"}),
          id_value: supplier_identifier |> xpath(~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
