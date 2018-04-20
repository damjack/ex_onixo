defmodule ExOnixo.Parser.Product.ProductSupply do
  import SweetXml
  alias ExOnixo.Parser.Product.ProductSupply.SupplyDetail

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductSupply"l)
    |> Enum.map(fn product_supply ->
      %{
          supply_details: SupplyDetail.parse_recursive(product_supply)
        }
      end)
    |> Enum.to_list
    |> handle_list
  end

  defp handle_list(nil), do: {:error, ""}
  defp handle_list(list), do: list
end
