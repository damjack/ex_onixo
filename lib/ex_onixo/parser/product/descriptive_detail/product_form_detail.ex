defmodule ExOnixo.Parser.Product.DescriptiveDetail.ProductFormDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductFormDetail"l)
    |> Enum.map(fn product_form_detail ->
        %{
            code: product_form_detail |> xpath(~x"./text()"s),
            text: RecordYml.get_human(product_form_detail, %{tag: "/", codelist: "ProductFormDetail"}),
          }
      end)
    |> Enum.to_list
  end
end
