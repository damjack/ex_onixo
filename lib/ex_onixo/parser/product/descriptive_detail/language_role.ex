defmodule ExOnixo.Parser.Product.DescriptiveDetail.LanguageRole do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Language/LanguageRole"l)
    |> Enum.map(fn language_role ->
        %{
            code: ElementYml.get_tag(language_role, "/", "LanguageRole"),
            text: xpath(language_role, ~x"./text()"s)
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
