defmodule ExOnixo.Parser.Product.PublishingDetail.PublishingDate do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./PublishingDate"l)
    |> Enum.map(fn publishing_date ->
        %{
          role: ElementYml.get_tag(publishing_date, "/PublishingDateRole", "PublishingDateRole"),
          date: ExOnixo.Helper.Date.to_date_without_code(publishing_date),
          date_text: xpath(publishing_date, ~x"./Date/text()"s)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
