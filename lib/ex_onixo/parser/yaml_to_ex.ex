defmodule ExOnixo.Parser.YamlToEx do
  defmacro tags(name, version) do
    quote do
      def unquote(name)() do
        YamlElixir.read_from_file("data/onix#{unquote(version)}/tagnames.yml")
        |> Enum.map(fn tag ->
            %{
              elem(tag, 0) => YamlElixir.read_from_file("data/onix#{unquote(version)}/codelists/codelist_#{elem(tag, 1)}.yml")
            }
          end)
        |> Enum.to_list
        |> Enum.reduce(%{}, fn (map, acc) -> Map.merge(acc, map) end)
      end
    end
  end
end
