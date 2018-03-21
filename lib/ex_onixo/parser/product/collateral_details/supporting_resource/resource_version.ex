defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource.ResourceVersion do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.CollateralDetail.SupportingResource.ResourceVersion.{ResourceVersionFeature, ContentDate}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ResourceVersion"l)
    |> Enum.map(fn resource_version ->
        %{
          resource_form: RecordYml.get_human(resource_version, %{tag: "/ResourceForm", codelist: "ResourceForm"}),
          resource_version_features: ResourceVersionFeature.parse_recursive(resource_version),
          resource_link: resource_version |> xpath(~x"./ResourceLink/text()"s),
          content_dates: ContentDate.parse_recursive(resource_version)
        }
      end)
    |> Enum.to_list
  end
end
