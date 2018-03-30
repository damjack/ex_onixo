defmodule ExOnixo.Parser.Product.RelatedMaterial.WorkRelationCode do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    related_materials =
      SweetXml.xpath(xml, ~x"./RelatedWork/WorkRelationCode"l)
      |> Enum.map(fn work_relation_code ->
          %{
            code: ElementYml.get_tag(work_relation_code, "/", "WorkRelationCode"),
            text: xpath(work_relation_code, ~x"./text()"s)
          }
        end)
      |> Enum.to_list
    unless Enum.empty?(related_materials) do
      Enum.fetch!(related_materials, 0)
    end
  end
end
