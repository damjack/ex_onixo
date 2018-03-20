defmodule ExOnixo.Parser.Product21.MediaFile do
  import SweetXml
  alias ExOnixo.Parser.RecordYml21

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./MediaFile"l)
    |> Enum.map(fn media_file ->
        %{
          media_file_type_code: RecordYml21.get_human(media_file, %{tag: "/MediaFileTypeCode", codelist: "MediaFileTypeCode"}),
          media_file_link_type_code: RecordYml21.get_human(media_file, %{tag: "/MediaFileLinkTypeCode", codelist: "MediaFileLinkTypeCode"}),
          media_file_link: media_file |> xpath(~x"./MediaFileLink/text()"s),
          media_file_date: media_file |> xpath(~x"./MediaFileDate/text()"s),
        }
      end)
    |> Enum.to_list
  end
end
