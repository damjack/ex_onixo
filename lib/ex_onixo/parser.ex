defmodule ExOnixo.Parser do
  import SweetXml
  alias ExOnixo.Parser.{
    Product,
    Product21,
    Sender,
    Sender21
  }
  @moduledoc false
  defdelegate raw_xml(xml_tree), to: ExOnixo.Raw

  defp init_stream_parser(origin) do
    init_stream(origin)
      |> SweetXml.stream_tags([:Product], discard: [:Product])
  end

  def parse_stream_product(origin, %{release: "3.0"}) do
    init_stream_parser(origin)
      |> Stream.map(fn {_, doc} ->
          Product.parse_recursive(doc)
          |> IO.inspect
        end)
      |> Enum.to_list
  end
  def parse_stream_product(origin, %{release: "2.1"}) do
    init_stream_parser(origin)
      |> Stream.map(fn {_, doc} ->
          Product21.parse_recursive(doc)
        end)
      |> Enum.to_list
  end

  def raw_stream(origin, opts) do
    init_stream(origin)
      |> SweetXml.stream_tags(String.to_atom(opts[:tag]), discard: [String.to_atom(opts[:tag])])
      |> Stream.map(fn
        {_, doc} ->
          SweetXml.xpath(doc, ~x"//opts[:tag]"l)
          # |> ExOnixo.raw_xml
        end)
      |> Enum.to_list
  end

  def parse_stream_sender("", _args), do: {:error, "File not found"}
  def parse_stream_sender(origin, %{release: "3.0"}),
    do: init_stream(origin) |> Sender.parse_recursive
  def parse_stream_sender(origin, %{release: "2.1"}),
    do: init_stream(origin) |> Sender21.parse_recursive

  defp init_stream(""), do: {:error, "No file found"}
  defp init_stream(origin) do
    File.stream! origin
  end
end
