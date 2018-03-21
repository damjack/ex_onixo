defmodule ExOnixo.Parser.Product.RelatedMaterial.WorkRelationCode do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    related_materials =
      SweetXml.xpath(xml, ~x"./RelatedWork/WorkRelationCode"l)
      |> Enum.map(fn work_relation_code ->
          %{
            code: RecordYml.get_human(work_relation_code, %{tag: "/", codelist: "WorkRelationCode"}),
            text: work_relation_code |> xpath(~x"./text()"s)
          }
        end)
      |> Enum.to_list
    unless Enum.empty?(related_materials) do
      Enum.fetch!(related_materials, 0)
    end
  end
end
