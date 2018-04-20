defmodule ExOnixo.Parser.Product21.Publisher do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Publisher"l)
    |> Enum.map(fn publisher ->
        %{
          publisher_role: ElementYml.get_tag(publisher, "/PublishingRole", "PublishingRole"),
          name_code_type: xpath(publisher, ~x"./NameCodeType/text()"s),
          name_code_type_name: xpath(publisher, ~x"./NameCodeTypeName/text()"s),
          name_code_value: xpath(publisher, ~x"./NameCodeValue/text()"s),
          publisher_name: xpath(publisher, ~x"./PublisherName/text()"s)
        }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
