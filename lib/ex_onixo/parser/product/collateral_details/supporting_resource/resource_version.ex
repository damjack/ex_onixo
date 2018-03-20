defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource.ResourceVersion do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ResourceVersion"l)
    |> Enum.map(fn resource_version ->
        %{
          resource_form: RecordYml.get_human(resource_version, %{tag: "/ResourceForm", codelist: "ResourceForm"}),
          feature_type: RecordYml.get_human(resource_version, %{tag: "/ResourceVersionFeature/ResourceVersionFeatureType", codelist: "ResourceVersionFeatureType"}),
          feature_value: resource_version |> xpath(~x"./ResourceVersionFeature/FeatureValue/text()"s),
          resource_link: resource_version |> xpath(~x"./ResourceLink/text()"s),
          content_date_role: resource_version |> xpath(~x"./ContentDate/ContentDateRoleCode/text()"s),
          date: ExOnixo.Helper.Date.to_date(xpath(resource_version, ~x"./ContentDate/Date/@dateformat"s), xpath(resource_version, ~x"./ContentDate/Date/text()"s))
        }
      end)
    |> Enum.to_list
  end
end
