defmodule ExOnixo.Parser.Product.RelatedMaterial.RelatedWorkIdentifier do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./RelatedWork/WorkIdentifier"l)
    |> Enum.map(fn related_work_identifier ->
        %{
          work_id_type: RecordYml.get_tag(related_work_identifier, "/WorkIDType", "WorkIDType"),
          id_value: related_work_identifier |> xpath(~x"./IDValue/text()"s)
        }
      end)
    |> Enum.to_list
  end
end
