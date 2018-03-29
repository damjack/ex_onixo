defmodule ExOnixo.Parser.Product.PublishingDetail.PublishingDate do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./PublishingDate"l)
    |> Enum.map(fn publishing_date ->
        %{
          role: RecordYml.get_tag(publishing_date, "/PublishingDateRole", "PublishingDateRole"),
          date: ExOnixo.Helper.Date.to_date_without_code(publishing_date),
          date_text: publishing_date |> xpath(~x"./Date/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
