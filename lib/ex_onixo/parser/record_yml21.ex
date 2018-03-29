defmodule ExOnixo.Parser.RecordYml21 do
  import SweetXml
  import YamlElixir

  def get_human(xml, opts) do
    xpath(xml, ~x".#{opts[:tag]}/text()"s)
      |> codelist_yml(opts[:codelist])
  end

  defp codelist_yml(code, name) do
    read_from_file("data/onix21/tagnames.yml")
      |> Map.fetch(name)
      |> handle_list(code)
  end

  defp handle_list(list, _code) when is_atom(list), do: nil
  defp handle_list(list, code) when is_tuple(list), do: handle_list(elem(list, 1), code)
  defp handle_list(list, code) do
    read_from_file("data/onix21/codelists/codelist_#{list}.yml")[code]
  end
end
