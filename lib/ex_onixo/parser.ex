defmodule ExOnixo.Parser do
  import SweetXml
  @moduledoc false
  defdelegate raw_xml(xml_tree), to: ExOnixo.Raw

  def parse_direct(origin, opts) do
    file = set(origin)
    doc = SweetXml.parse(file)
    doc |> SweetXml.xpath(
      ~x"//#{opts[:tag]}"l,
      record_reference: ~x"./RecordReference/text()",
      notification_type: ~x"./NotificationType/text()",
      identifiers: [
        ~x".//ProductIdentifier",
        type: ~x"./ProductIDType/text()",
        value: ~x"./IDValue/text()"
      ]
    )
  end

  def parse_stream(origin, opts) do
    file = set_stream(origin)
    file
      |> SweetXml.stream_tags(String.to_atom(opts[:tag]), discard: [String.to_atom(opts[:tag])])
      |> Stream.map(fn
        {_, doc} ->
          doc |> SweetXml.xpath(~x"//opts[:tag]"l)
          |> ExOnixo.raw_xml
          IO.inspect(doc)
        end)
      |> Enum.to_list
  end

  defp set(origin) do
    File.read! origin
  end

  defp set_stream(origin) do
    File.stream! origin
  end
end
