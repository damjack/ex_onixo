defmodule ExOnixo.Parser.Product.PublishingDetail.SalesRestriction do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SalesRestriction"l)
    |> Enum.map(fn sales_restriction ->
        %{
          sales_restriction_type: RecordYml.get_tag(sales_restriction, "/SalesRestrictionType", "SalesRestrictionType")
        }
      end)
    |> Enum.to_list
  end
end
