defmodule ExOnixo.Parser.Product.DescriptiveDetail do
  import SweetXml
  alias ExOnixo.Helper.ElementYml
  alias ExOnixo.Parser.Product.DescriptiveDetail.{
    ProductFormDetail, Extent, EpubUsageConstraint,
    Collection, TitleDetail, Contributor, Subject,
    LanguageCode, LanguageRole
  }

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./DescriptiveDetail"l)
      |> Enum.map(fn descriptive_detail ->
        %{
            product_composition: ElementYml.get_tag(descriptive_detail, "/ProductComposition", "ProductComposition"),
            product_form: ElementYml.get_tag(descriptive_detail, "/ProductForm", "ProductForm"),
            product_form_details: ProductFormDetail.parse_recursive(descriptive_detail),
            primary_content_type: xpath(descriptive_detail, ~x"./PrimaryContentType/text()"s),
            product_content_type: xpath(descriptive_detail, ~x"./ProductContentType/text()"s),
            epub_technical_protection: ElementYml.get_tag(descriptive_detail, "/EpubTechnicalProtection", "EpubTechnicalProtection"),
            edition_number: xpath(descriptive_detail, ~x"./EditionNumber/text()"s),
            language_roles: LanguageRole.parse_recursive(descriptive_detail),
            language_codes: LanguageCode.parse_recursive(descriptive_detail),
            extents: Extent.parse_recursive(descriptive_detail),
            epub_usage_constraints: EpubUsageConstraint.parse_recursive(descriptive_detail),
            collections: Collection.parse_recursive(descriptive_detail),
            title_details: TitleDetail.parse_recursive(descriptive_detail),
            contributors: Contributor.parse_recursive(descriptive_detail),
            subjects: Subject.parse_recursive(descriptive_detail)
          }
        end)
      |> Enum.to_list
      |> handle_maps
  end

  defp handle_maps(nil), do: %{}
  defp handle_maps([]), do: %{}
  defp handle_maps(list) do
    List.first(list)
  end
end
