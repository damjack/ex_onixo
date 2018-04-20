defmodule ExOnixo.Parser.Product21.MediaFile do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./MediaFile"l)
    |> Enum.map(fn media_file ->
        %{
          media_file_type_code: ElementYml.get_tag21(media_file, "/MediaFileTypeCode", "MediaFileTypeCode"),
          media_file_link_type_code: ElementYml.get_tag21(media_file, "/MediaFileLinkTypeCode", "MediaFileLinkTypeCode"),
          media_file_link: xpath(media_file, ~x"./MediaFileLink/text()"s),
          media_file_date: xpath(media_file, ~x"./MediaFileDate/text()"s),
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
