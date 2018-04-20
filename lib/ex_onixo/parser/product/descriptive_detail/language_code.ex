defmodule ExOnixo.Parser.Product.DescriptiveDetail.LanguageCode do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Language/LanguageCode"l)
    |> Enum.map(fn language_code ->
        %{
            code: ElementYml.get_tag(language_code, "/", "LanguageCode"),
            text: xpath(language_code, ~x"./text()"s)
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
