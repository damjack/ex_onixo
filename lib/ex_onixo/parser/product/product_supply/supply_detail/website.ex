defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Website do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Supplier/Website"l)
    |> Enum.map(fn website ->
        %{
          website_type: RecordYml.get_human(website, %{tag: "/WebsiteRole", codelist: "WebsiteRole"}),
          website_link: website |> xpath(~x"./WebsiteLink/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
