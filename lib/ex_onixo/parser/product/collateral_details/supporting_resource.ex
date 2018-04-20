defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource do
  import SweetXml
  alias ExOnixo.Helper.ElementYml
  alias ExOnixo.Parser.Product.CollateralDetail.SupportingResource.{ResourceVersion}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./SupportingResource"l)
    |> Enum.map(fn supporting_resource ->
        %{
          resource_content_type: ElementYml.get_tag(supporting_resource, "/ResourceContentType", "ResourceContentType"),
          content_audience: ElementYml.get_tag(supporting_resource, "/ContentAudience", "ContentAudience"),
          resource_mode: ElementYml.get_tag(supporting_resource, "/ResourceMode", "ResourceMode"),
          resource_versions: ResourceVersion.parse_recursive(supporting_resource)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
