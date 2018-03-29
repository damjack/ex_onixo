defmodule Mix.Tasks.Codelist.YamlToEx do
  use Mix.Task
  @shortdoc "Convert yml from data dir to Elixir Map"
  @moduledoc ~S"""
   This is used to convert yml from data dir to Elixir Map into Tag module.
   #Usage
   ```
      mix codelist.yaml_to_ex
   ```
  """

  def run(_args) do
    Application.ensure_all_started(:yamerl)
    # IO.puts "args: #{inspect(args, [pretty: true, width: 0])}"
    yaml30 =
      YamlElixir.read_from_file("data/onix30/tagnames.yml")
        |> Enum.map(fn tag ->
            "\"#{elem(tag, 0)}\" => %{#{YamlElixir.read_from_file("data/onix30/codelists/codelist_#{elem(tag, 1)}.yml") |> Enum.map(fn tag -> "\"#{elem(tag, 0)}\" => \"#{elem(tag, 1)}\"," end) |> List.to_string |> String.slice(0..-2)}},"
          end)
        |> List.to_string |> String.slice(0..-2)
    yaml21 =
      YamlElixir.read_from_file("data/onix21/tagnames.yml")
        |> Enum.map(fn tag ->
            "\"#{elem(tag, 0)}\" => %{#{YamlElixir.read_from_file("data/onix21/codelists/codelist_#{elem(tag, 1)}.yml") |> Enum.map(fn tag -> "\"#{elem(tag, 0)}\" => \"#{elem(tag, 1)}\"," end) |> List.to_string |> String.slice(0..-2)}},"
          end)
        |> List.to_string |> String.slice(0..-2)

    output = "defmodule ExOnixo.Parser.Tags do
  def tag30 do
    %{#{yaml30}}
  end

  def tag21 do
    %{#{yaml21}}
  end
end"

    {:ok, file} = File.open "lib/ex_onixo/parser/tags.ex", [:write]
    IO.binwrite file, output
    File.close file
  end
end
