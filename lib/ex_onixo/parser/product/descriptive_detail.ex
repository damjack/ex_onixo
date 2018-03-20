defmodule ExOnixo.Parser.Product.DescriptiveDetail do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.DescriptiveDetail.{ProductFormDetail, Extent, EpubUsageConstraint, Collection, TitleDetail, Contributor, Subject}

  def parse_recursive(xml) do
    descriptive_details =
      SweetXml.xpath(xml, ~x"./DescriptiveDetail"l)
      |> Enum.map(fn descriptive_detail ->
        %{
            product_composition: RecordYml.get_human(descriptive_detail, %{tag: "/ProductComposition", codelist: "ProductComposition"}),
            product_form: RecordYml.get_human(descriptive_detail, %{tag: "/ProductForm", codelist: "ProductForm"}),
            product_form_details: ProductFormDetail.parse_recursive(descriptive_detail),
            primary_content_type: descriptive_detail |> xpath(~x"./PrimaryContentType/text()"s),
            product_content_type: descriptive_detail |> xpath(~x"./ProductContentType/text()"s),
            epub_technical_protection: RecordYml.get_human(descriptive_detail, %{tag: "/EpubTechnicalProtection", codelist: "EpubTechnicalProtection"}),
            edition_number: descriptive_detail |> xpath(~x"./EditionNumber/text()"s),
            language_role: RecordYml.get_human(descriptive_detail, %{tag: "/Language/LanguageRole", codelist: "LanguageRole"}),
            language_code: RecordYml.get_human(descriptive_detail, %{tag: "/Language/LanguageCode", codelist: "LanguageCode"}),
            extent: Extent.parse_recursive(descriptive_detail),
            epub_usage_constraints: EpubUsageConstraint.parse_recursive(descriptive_detail),
            collections: Collection.parse_recursive(descriptive_detail),
            title_details: TitleDetail.parse_recursive(descriptive_detail),
            contributors: Contributor.parse_recursive(descriptive_detail),
            subjects: Subject.parse_recursive(descriptive_detail)
          }
        end)
      |> Enum.to_list
    unless Enum.empty?(descriptive_details) do
      Enum.fetch!(descriptive_details, 0)
    end
  end
end
