defmodule ExOnixo do
  alias ExOnixo.Parser
  @moduledoc false

  def read_sender(path, args) do
    Parser.parse_read_sender(path, args)
  end

  def stream_sender(path, args) do
    Parser.parse_stream_sender(path, args)
  end

  def read_product(path) do
    Parser.init_read_parser(path)
  end

  def stream_product(path) do
    Parser.init_stream_parser(path)
  end

  # @spec raw_xml(xml_tree | binary, keyword) :: binary
  defdelegate raw_xml(xml_tree), to: ExOnixo.Raw
end
