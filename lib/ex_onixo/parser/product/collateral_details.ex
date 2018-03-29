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
      |> handle_list
  end

  defp handle_list(nil), do: nil
  defp handle_list([]), do: nil
  defp handle_list(list) do
    List.first(list)
  end
end
