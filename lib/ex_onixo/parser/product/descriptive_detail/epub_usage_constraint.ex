defmodule ExOnixo.Parser.Product.DescriptiveDetail.EpubUsageConstraint do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./EpubUsageConstraint"l)
    |> Enum.map(fn epub_usage_constraint ->
        %{
            epub_usage_type: ElementYml.get_tag(epub_usage_constraint, "/EpubUsageType", "EpubUsageType"),
            epub_usage_status: ElementYml.get_tag(epub_usage_constraint, "/EpubUsageStatus", "EpubUsageStatus"),
            epub_usage_limit_quantity: xpath(epub_usage_constraint, ~x"./EpubUsageLimit/Quantity/text()"s),
            epub_usage_limit_epub_usage_unit: ElementYml.get_tag(epub_usage_constraint, "/EpubUsageLimit/EpubUsageUnit", "EpubUsageUnit")
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
