defmodule ExOnixo.Parser.Product.CollateralDetail do
  import SweetXml
  alias ExOnixo.Parser.Product.CollateralDetail.{TextContent, SupportingResource}

  def parse_recursive(xml) do
    collateral_details =
      SweetXml.xpath(xml, ~x"./CollateralDetail"l)
      |> Enum.map(fn collateral_detail ->
          %{
            text_contents: TextContent.parse_recursive(collateral_detail),
            supporting_resources: SupportingResource.parse_recursive(collateral_detail)
          }
        end)
      |> Enum.to_list
    unless Enum.empty?(collateral_details) do
      Enum.fetch!(collateral_details, 0)
    end
  end
end
