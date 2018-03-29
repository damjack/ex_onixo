defmodule ExOnixo.Parser.Product.DescriptiveDetail.EpubUsageConstraint do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./EpubUsageConstraint"l)
    |> Enum.map(fn epub_usage_constraint ->
        %{
            epub_usage_type: RecordYml.get_tag(epub_usage_constraint, "/EpubUsageType", "EpubUsageType"),
            epub_usage_status: RecordYml.get_tag(epub_usage_constraint, "/EpubUsageStatus", "EpubUsageStatus"),
            epub_usage_limit_quantity: epub_usage_constraint |> xpath(~x"./EpubUsageLimit/Quantity/text()"s),
            epub_usage_limit_epub_usage_unit: RecordYml.get_tag(epub_usage_constraint, "/EpubUsageLimit/EpubUsageUnit", "EpubUsageUnit")
          }
      end)
    |> Enum.to_list
  end
end
