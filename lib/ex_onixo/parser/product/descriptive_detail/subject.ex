defmodule ExOnixo.Parser.Product.DescriptiveDetail.Subject do
  import SweetXml
  alias ExOnixo.Helper.ElementYml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./Subject"l)
    |> Enum.map(fn subject ->
        %{
            subject_scheme_identifier: ElementYml.get_tag(subject, "/SubjectSchemeIdentifier", "SubjectSchemeIdentifier"),
            subject_scheme_name: xpath(subject, ~x"./SubjectSchemeName/text()"s),
            subject_code: xpath(subject, ~x"./SubjectCode/text()"s),
            subject_heading_text: xpath(subject, ~x"./SubjectHeadingText/text()"s)
          }
      end)
    |> Enum.to_list
  end
end
