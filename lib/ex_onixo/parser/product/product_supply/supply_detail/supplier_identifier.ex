defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.SupplierIdentifier do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Supplier/SupplierIdentifier"l)
    |> Enum.map(fn supplier_identifier ->
        %{
          supplier_id_type: ElementYml.get_tag(supplier_identifier, "/SupplierIDType", "SupplierIDType"),
          id_value: xpath(supplier_identifier, ~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
