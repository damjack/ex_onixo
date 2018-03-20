defmodule ExOnixo.Parser.Product.DescriptiveDetail.Contributor do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Contributor"l)
    |> Enum.map(fn contributor ->
        %{
            contributor_role: RecordYml.get_human(contributor, %{tag: "/ContributorRole", codelist: "ContributorRole"}),
            sequence_number: contributor |> xpath(~x"./SequenceNumber/text()"s),
            person_name: contributor |> xpath(~x"./PersonName/text()"s),
            person_name_inverted: contributor |> xpath(~x"./PersonNameInverted/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
