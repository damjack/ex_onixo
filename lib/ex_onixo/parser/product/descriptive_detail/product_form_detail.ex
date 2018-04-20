defmodule ExOnixo.Parser.Product.DescriptiveDetail.ProductFormDetail do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ProductFormDetail"l)
    |> Enum.map(fn product_form_detail ->
        %{
            code: xpath(product_form_detail, ~x"./text()"s),
            text: ElementYml.get_tag(product_form_detail, "/", "ProductFormDetail")
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
