defmodule ExOnixo.Parser.Product.PublishingDetail.Publisher do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Publisher"l)
    |> Enum.map(fn publisher ->
        %{
          code_role: xpath(publisher, ~x"./PublishingRole/text()"s),
          text_role: ElementYml.get_tag(publisher, "/PublishingRole", "PublishingRole"),
          name: xpath(publisher, ~x"./PublisherName/text()"s)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
