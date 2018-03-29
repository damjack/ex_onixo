defmodule ExOnixo.Parser.Product.ProductSupply.SupplyDetail.Website do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Supplier/Website"l)
    |> Enum.map(fn website ->
        %{
          website_type: RecordYml.get_tag(website, "/WebsiteRole", "WebsiteRole"),
          website_link: xpath(website, ~x"./WebsiteLink/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
