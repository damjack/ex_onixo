defmodule ExOnixo.Parser.Product.PublishingDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.PublishingDetail.{PublishingDate, SalesRestriction, SalesRight}

  def parse_recursive(xml) do
    publishing_details =
      SweetXml.xpath(xml, ~x"./PublishingDetail"l)
      |> Enum.map(fn publishing_detail ->
          %{
            publishing_role: RecordYml.get_human(publishing_detail, %{tag: "/Publisher/PublishingRole", codelist: "PublishingRole"}),
            publisher_name: publishing_detail |> xpath(~x"./Publisher/PublisherName/text()"s),
            publishing_status: RecordYml.get_human(publishing_detail, %{tag: "/PublishingStatus", codelist: "PublishingStatus"}),
            publishing_date: PublishingDate.parse_recursive(publishing_detail),
            sales_restrictions: SalesRestriction.parse_recursive(publishing_detail),
            sales_rights: SalesRight.parse_recursive(publishing_detail)
          }
        end)
      |> Enum.to_list
    unless Enum.empty?(publishing_details) do
      Enum.fetch!(publishing_details, 0)
    end
  end
end
