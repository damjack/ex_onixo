defmodule ExOnixo.Parser.Product21.Set do
  import SweetXml
  alias ExOnixo.Parser.RecordYml
  alias ExOnixo.Parser.Product21.Set.Identifier

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Set"l)
    |> Enum.map(fn set ->
        %{
          identifier: Identifier.parse_recursive(set),
          title_of_set: set |> xpath(~x"./TitleOfSet/text()"s),
          item_number_within_set: set |> xpath(~x"./ItemNumberWithinSet/text()"s),
          set_item_title: set |> xpath(~x"./SetItemTitle/text()"s)
        }
      end)
    |> Enum.to_list
  end
end