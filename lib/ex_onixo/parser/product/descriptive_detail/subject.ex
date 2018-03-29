defmodule ExOnixo.Parser.Product.DescriptiveDetail.Subject do
  import SweetXml
  alias ExOnixo.Parser.RecordYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Subject"l)
    |> Enum.map(fn subject ->
        %{
            subject_scheme_identifier: RecordYml.get_tag(subject, "/SubjectSchemeIdentifier", "SubjectSchemeIdentifier"),
            subject_scheme_name: subject |> xpath(~x"./SubjectSchemeName/text()"s),
            subject_code: subject |> xpath(~x"./SubjectCode/text()"s),
            subject_heading_text: subject |> xpath(~x"./SubjectHeadingText/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
