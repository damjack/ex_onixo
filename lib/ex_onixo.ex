defmodule ExOnixo do
  alias ExOnixo.Parser
  @moduledoc false

  @spec stream_sender(binary, keyword) :: binary
  def stream_sender(path, args) do
    Parser.parse_stream_sender(path, args)
  end

  @spec stream_product(binary, keyword) :: binary
  def stream_product(path, args) do
    Parser.parse_stream_product(path, args)
  end

  # @spec raw_xml(xml_tree | binary, keyword) :: binary
  # defdelegate raw_xml(xml_tree), to: ExOnixo.Raw
end
