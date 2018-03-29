defmodule ExOnixo.Parser.Record21 do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product.{Identifier, DescriptiveDetail.Contributor, DescriptiveDetail.Subject}
  alias ExOnixo.Parser.Product21.{Serie, Set, Illustration, OtherText, MediaFile, Imprint, Publisher, SupplyDetail}

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"//Product")
      |> to_map
  end

  defp to_map(xml) do
    %{
        record_reference: xpath(xml, ~x"./RecordReference/text()"s),
        notification_type: notification(RecordYml.get_tag21(xml, "/NotificationType", "NotificationType")),
        record_source_name: xpath(xml, ~x"./RecordReference/text()"s),
        product_identifiers: Identifier.parse_recursive(xml),
        product_form: RecordYml.get_tag(xml, "/ProductForm", "ProductForm"),
        product_form_description: xpath(xml, ~x"./ProductFormDescription/text()"s),
        trade_category: xpath(xml, ~x"./TradeCategory/text()"s),
        series: Serie.parse_recursive(xml),
        sets: Set.parse_recursive(xml),
        contributors: Contributor.parse_recursive(xml),
        title_type: xpath(xml, ~x"./Title/TitleType/text()"s),
        title_text: xpath(xml, ~x"./Title/TitleText/text()"s),
        title_prefix: xpath(xml, ~x"./Title/TitlePrefix/text()"s),
        title_without_prefix: xpath(xml, ~x"./Title/TitleWithoutPrefix/text()"s),
        edition_number: xpath(xml, ~x"./EditionNumber/text()"s),
        edition_statement: xpath(xml, ~x"./EditionStatement/text()"s),
        number_of_pages: xpath(xml, ~x"./NumberOfPages/text()"s),
        pages_roman: xpath(xml, ~x"./PagesRoman/text()"s),
        pages_arabic: xpath(xml, ~x"./PagesArabic/text()"s),
        illustrations: Illustration.parse_recursive(xml),
        subjects: Subject.parse_recursive(xml),
        other_texts: OtherText.parse_recursive(xml),
        media_files: MediaFile.parse_recursive(xml),
        imprints: Imprint.parse_recursive(xml),
        publishers: Publisher.parse_recursive(xml),
        publishing_status: RecordYml.get_tag(xml, "/PublishingStatus", "PublishingStatus"),
        publication_date: ExOnixo.Helper.Date.check_and_parse(xpath(xml, ~x"./PublicationDate/text()"s)),
        publication_date_text: xpath(xml, ~x"./PublicationDate/text()"s),
        out_of_print_date: ExOnixo.Helper.Date.check_and_parse(xpath(xml, ~x"./OutOfPrintDate/text()"s)),
        out_of_print_date_text: xpath(xml, ~x"./OutOfPrintDate/text()"s),
        supply_detail: SupplyDetail.parse_recursive(xml)
      }
  end

  defp notification(code) do
    case code do
      "EarlyNotification" ->
        "draft"
      "AdvanceNotificationConfirmed" ->
        "confirm"
      "NotificationConfirmedOnPublication" ->
        "publish"
      "UpdatePartial" ->
        "confirm"
      "Delete" ->
        "mark_delete"
      _ ->
        "test"
    end
  end
end
