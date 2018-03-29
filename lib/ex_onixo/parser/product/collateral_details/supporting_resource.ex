defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.CollateralDetail.SupportingResource.{ResourceVersion}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SupportingResource"l)
    |> Enum.map(fn supporting_resource ->
        %{
          resource_content_type: RecordYml.get_tag(supporting_resource, "/ResourceContentType", "ResourceContentType"),
          content_audience: RecordYml.get_tag(supporting_resource, "/ContentAudience", "ContentAudience"),
          resource_mode: RecordYml.get_tag(supporting_resource, "/ResourceMode", "ResourceMode"),
          resource_versions: ResourceVersion.parse_recursive(supporting_resource)
        }
      end)
    |> Enum.to_list
  end
end
