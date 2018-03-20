defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.CollateralDetail.SupportingResource.{ResourceVersion}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SupportingResource"l)
    |> Enum.map(fn supporting_resource ->
        %{
          resource_content_type: RecordYml.get_human(supporting_resource, %{tag: "/ResourceContentType", codelist: "ResourceContentType"}),
          content_audience: RecordYml.get_human(supporting_resource, %{tag: "/ContentAudience", codelist: "ContentAudience"}),
          resource_mode: RecordYml.get_human(supporting_resource, %{tag: "/ResourceMode", codelist: "ResourceMode"}),
          resource_versions: ResourceVersion.parse_recursive(supporting_resource)
        }
      end)
    |> Enum.to_list
  end
end
