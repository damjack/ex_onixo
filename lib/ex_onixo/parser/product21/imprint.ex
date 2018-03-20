defmodule ExOnixo.Parser.Product21.Imprint do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Imprint"l)
    |> Enum.map(fn imprint ->
        %{
          name_code_type: imprint |> xpath(~x"./NameCodeType/text()"s),
          name_code_type_name: imprint |> xpath(~x"./NameCodeTypeName/text()"s),
          name_code_value: imprint |> xpath(~x"./NameCodeValue/text()"s),
          imprint_name: imprint |> xpath(~x"./ImprintName/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
