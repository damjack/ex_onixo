defmodule ExOnixo.Parser.RecordYml do
  import SweetXml
  # import YamlElixir
  alias ExOnixo.Parser.Tags

  def get_tag(xml, tag, text) do
    code = xpath(xml, ~x".#{tag}/text()"s)
    Tags.tag30[text][code]
  end

  def get_tag21(xml, tag, text) do
    code = xpath(xml, ~x".#{tag}/text()"s)
    Tags.tag21[text][code]
  end

  # def get_human(xml, opts) do
  #   xpath(xml, ~x".#{opts[:tag]}/text()"s)
  #     |> codelist_yml(opts[:codelist])
  # end
  #
  # defp codelist_yml(code, name) do
  #   read_from_file("data/onix30/tagnames.yml")
  #     |> Map.fetch(name)
  #     |> handle_list(code)
  # end
  #
  # defp handle_list(list, _code) when is_atom(list), do: nil
  # defp handle_list(list, code) when is_tuple(list), do: handle_list(elem(list, 1), code)
  # defp handle_list(list, code) do
  #   read_from_file("data/onix30/codelists/codelist_#{list}.yml")[code]
  # end
end
