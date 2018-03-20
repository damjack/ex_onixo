defmodule ExOnixo.Parser.RecordYml21 do
  import SweetXml
  import YamlElixir

  def get_human(xml, opts) do
    xml
      |> xpath(~x".#{opts[:tag]}/text()"s)
      |> codelist_yml(opts[:codelist])
  end

  defp codelist_yml(code, name) do
    list =
      read_from_file("data/onix21/tagnames.yml")
      |> Map.fetch!(name)

    if String.length(code) !== 0 do
      read_from_file("data/onix21/codelists/codelist_#{list}.yml")
      |> Map.fetch!(code)
    end
  end
end
