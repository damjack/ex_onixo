defmodule ExOnixo.Parser.Product21.MediaFile do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./MediaFile"l)
    |> Enum.map(fn media_file ->
        %{
          media_file_type_code: RecordYml.get_tag21(media_file, "/MediaFileTypeCode", "MediaFileTypeCode"),
          media_file_link_type_code: RecordYml.get_tag21(media_file, "/MediaFileLinkTypeCode", "MediaFileLinkTypeCode"),
          media_file_link: media_file |> xpath(~x"./MediaFileLink/text()"s),
          media_file_date: media_file |> xpath(~x"./MediaFileDate/text()"s),
        }
      end)
    |> Enum.to_list
  end
end
