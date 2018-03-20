defmodule ExOnixo.Parser.Product.DescriptiveDetail.Collection do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.DescriptiveDetail.Collection.TitleDetail

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Collection"l)
    |> Enum.map(fn collection ->
        %{
            collection_type: RecordYml.get_human(collection, %{tag: "/CollectionType", codelist: "CollectionType"}),
            title_detail: TitleDetail.parse_recursive(collection)
          }
      end)
    |> Enum.to_list
  end
end
