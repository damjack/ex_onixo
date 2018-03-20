defmodule ExOnixo.Parser.Product.PublishingDetail.PublishingDate do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./PublishingDate"l)
    |> Enum.map(fn publishing_date ->
        %{
          role: RecordYml.get_human(publishing_date, %{tag: "/PublishingDateRole", codelist: "PublishingDateRole"}),
          date: ExOnixo.Helper.Date.to_date(xpath(publishing_date, ~x"./Date/@dateformat"s), xpath(publishing_date, ~x"./Date/text()"s))
        }
      end)
    |> Enum.to_list
  end
end
