defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource.ResourceVersion.ResourceVersionFeature do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ResourceVersionFeature"l)
    |> Enum.map(fn resource_version_feature ->
        %{
          feature_type: RecordYml.get_human(resource_version_feature, %{tag: "/ResourceVersionFeatureType", codelist: "ResourceVersionFeatureType"}),
          feature_value: resource_version_feature |> xpath(~x"./FeatureValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
