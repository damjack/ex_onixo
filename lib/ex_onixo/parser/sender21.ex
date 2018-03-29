defmodule ExOnixo.Parser.Sender21 do
  import SweetXml

  def parse_recursive(xml) do
    xml
    |> SweetXml.stream_tags([:FromCompany, :SentDate], discard: [:FromCompany, :SentDate])
    |> Stream.map(fn {_, doc} ->
        %{
            from_company: xpath(doc, ~x"//FromCompany/text()"s),
            sent_date: xpath(doc, ~x"//SentDate/text()"s)
          }
      end)
    |> Enum.fetch!(0)
  end

  def convert(map) do
    %{
      name: map[:from_company],
      code: Slugger.slugify(map[:from_company] |> String.downcase)
    }
  end
end
