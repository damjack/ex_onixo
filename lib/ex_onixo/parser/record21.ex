defmodule ExOnixo.Parser.Record21 do
  import SweetXml
  alias ExOnixo.Parser.{RecordYml, RecordYml21}
  alias ExOnixo.Parser.Product.{Identifier, DescriptiveDetail.Contributor, DescriptiveDetail.Subject}
  alias ExOnixo.Parser.Product21.{Serie, Set, Illustration, OtherText, MediaFile, Imprint, Publisher, SupplyDetail}

  def parse_recursive(xml) do
    product = SweetXml.xpath(xml, ~x"//Product")
    %{
        record_reference: product |> xpath(~x"./RecordReference/text()"s),
        notification_type: RecordYml21.get_human(product, %{tag: "/NotificationType", codelist: "NotificationType"}),
        record_source_name: product |> xpath(~x"./RecordReference/text()"s),
        product_identifiers: Identifier.parse_recursive(product),
        product_form: RecordYml.get_human(product, %{tag: "/ProductForm", codelist: "ProductForm"}),
        product_form_description: product |> xpath(~x"./ProductFormDescription/text()"s),
        trade_category: product |> xpath(~x"./TradeCategory/text()"s),
        series: Serie.parse_recursive(product),
        sets: Set.parse_recursive(product),
        contributors: Contributor.parse_recursive(product),
        title_type: product |> xpath(~x"./Title/TitleType/text()"s),
        title_text: product |> xpath(~x"./Title/TitleText/text()"s),
        title_prefix: product |> xpath(~x"./Title/TitlePrefix/text()"s),
        title_without_prefix: product |> xpath(~x"./Title/TitleWithoutPrefix/text()"s),
        edition_number: product |> xpath(~x"./EditionNumber/text()"s),
        edition_statement: product |> xpath(~x"./EditionStatement/text()"s),
        number_of_pages: product |> xpath(~x"./NumberOfPages/text()"s),
        pages_roman: product |> xpath(~x"./PagesRoman/text()"s),
        pages_arabic: product |> xpath(~x"./PagesArabic/text()"s),
        illustrations: Illustration.parse_recursive(product),
        subjects: Subject.parse_recursive(product),
        other_texts: OtherText.parse_recursive(product),
        media_files: MediaFile.parse_recursive(product),
        imprints: Imprint.parse_recursive(product),
        publishers: Publisher.parse_recursive(product),
        publishing_status: RecordYml.get_human(product, %{tag: "/PublishingStatus", codelist: "PublishingStatus"}),
        # TODO
        # publication_date: ExOnixo.Helper.Date.to_date("05", xpath(product, ~x"./PublicationDate/text()"s)),
        # out_of_print_date: ExOnixo.Helper.Date.to_date("01", xpath(product, ~x"./OutOfPrintDate/text()"s))
        supply_detail: SupplyDetail.parse_recursive(product)
      }
  end
end
