defmodule ExOnixo.Parser.Product.DescriptiveDetail.Collection do
  import SweetXml
  alias ExOnixo.Helper.ElementYml
  alias ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Collection"l)
    |> Enum.map(fn collection ->
        %{
            collection_type: ElementYml.get_tag(collection, "/CollectionType", "CollectionType"),
            title_detail: TitleDetail.parse_recursive(collection)
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
