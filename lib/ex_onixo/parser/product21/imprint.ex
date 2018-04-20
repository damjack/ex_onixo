defmodule ExOnixo.Parser.Product21.Imprint do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Imprint"l)
    |> Enum.map(fn imprint ->
        %{
          name_code_type: xpath(imprint, ~x"./NameCodeType/text()"s),
          name_code_type_name: xpath(imprint, ~x"./NameCodeTypeName/text()"s),
          name_code_value: xpath(imprint, ~x"./NameCodeValue/text()"s),
          imprint_name: xpath(imprint, ~x"./ImprintName/text()"s)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
