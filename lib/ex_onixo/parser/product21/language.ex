defmodule ExOnixo.Parser.Product21.Language do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Language"l)
    |> Enum.map(fn language ->
        %{
            name_code: ElementYml.get_tag(language, "/LanguageCode", "LanguageCode"),
            name_text: xpath(language, ~x"./LanguageCode/text()"s),
            role_code: ElementYml.get_tag(language, "/LanguageRole", "LanguageRole"),
            role_text: xpath(language, ~x"./LanguageRole/text()"s)
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
