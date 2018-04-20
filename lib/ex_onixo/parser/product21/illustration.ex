defmodule ExOnixo.Parser.Product21.Illustration do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Illustrations"l)
    |> Enum.map(fn illustration ->
        %{
          illustration_type: ElementYml.get_tag21(illustration, "/illustrationType", "illustrationType")
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
