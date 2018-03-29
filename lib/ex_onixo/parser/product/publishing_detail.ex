defmodule ExOnixo.Parser.Product.PublishingDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.PublishingDetail.{
    PublishingDate,
    SalesRestriction,
    SalesRight,
    Publisher
  }

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./PublishingDetail"l)
      |> Enum.map(fn publishing_detail ->
          %{
            publishers: Publisher.parse_recursive(publishing_detail),
            publishing_status: RecordYml.get_tag(publishing_detail, "/PublishingStatus", "PublishingStatus"),
            publishing_date: PublishingDate.parse_recursive(publishing_detail),
            sales_restrictions: SalesRestriction.parse_recursive(publishing_detail),
            sales_rights: SalesRight.parse_recursive(publishing_detail)
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
