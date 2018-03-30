defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource.ResourceVersion.ResourceVersionFeature do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ResourceVersionFeature"l)
    |> Enum.map(fn resource_version_feature ->
        %{
          feature_type: ElementYml.get_tag(resource_version_feature, "/ResourceVersionFeatureType", "ResourceVersionFeatureType"),
          feature_value: xpath(resource_version_feature, ~x"./FeatureValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
