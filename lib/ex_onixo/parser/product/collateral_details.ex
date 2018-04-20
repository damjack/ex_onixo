defmodule ExOnixo.Parser.Product.CollateralDetail do
  import SweetXml
  alias ExOnixo.Parser.Product.CollateralDetail.{
    TextContent,
    SupportingResource
  }

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./CollateralDetail"l)
      |> Enum.map(fn collateral_detail ->
          %{
            text_contents: TextContent.parse_recursive(collateral_detail),
            supporting_resources: SupportingResource.parse_recursive(collateral_detail)
          }
        end)
      |> Enum.to_list
      |> handle_maps
  end

  defp handle_maps(nil), do: {:error, ""}
  defp handle_maps([]), do: {:error, ""}
  defp handle_maps(list) do
    List.first(list)
  end
end
