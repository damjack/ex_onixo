defmodule ExOnixo.Parser.Product.DescriptiveDetail.Contributor do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Contributor"l)
    |> Enum.map(fn contributor ->
        %{
            contributor_role_text: ElementYml.get_tag(contributor, "/ContributorRole", "ContributorRole"),
            contributor_role_code: xpath(contributor, ~x"./ContributorRole/text()"s),
            sequence_number: xpath(contributor, ~x"./SequenceNumber/text()"s),
            names_before_key: xpath(contributor, ~x"./NamesBeforeKey/text()"s),
            key_names: xpath(contributor, ~x"./KeyNames/text()"s),
            person_name: xpath(contributor, ~x"./PersonName/text()"s),
            person_name_inverted: xpath(contributor, ~x"./PersonNameInverted/text()"s),
            biographical_note: xpath(contributor, ~x"./BiographicalNote/text()"s)
          }
      end)
    |> Enum.to_list
    |> handle_error
  end

  defp handle_error([]), do: {:error, ""}
  defp handle_error(list), do: list
end
