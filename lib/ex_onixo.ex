defmodule ExOnixo do
  alias ExOnixo.{Parser}
  @moduledoc false

  # @spec analyze(binary) :: xml_tree | String.t()

  def analyze(file, opts \\ []) do
    Parser.parse_direct(file, opts)
  end

  # @spec sanalyze(xml_tree | binary, keyword) :: binary

  def sanalyze(file, opts \\ []) do
    Parser.parse_stream(file, opts)
  end

  # @spec raw_xml(xml_tree | binary, keyword) :: binary
  defdelegate raw_xml(xml_tree), to: ExOnixo.Raw
end
