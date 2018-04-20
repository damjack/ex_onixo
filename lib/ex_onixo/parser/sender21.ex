defmodule ExOnixo.Parser.Sender21 do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.stream_tags(xml, [:FromCompany, :SentDate], discard: [:FromCompany, :SentDate])
      |> Stream.map(fn {_, doc} ->
          %{
              from_company: xpath(doc, ~x"//FromCompany/text()"s),
              sent_date: xpath(doc, ~x"//SentDate/text()"s)
            }
        end)
      |> Enum.to_list
      |> handle_maps
  end

  defp handle_maps(nil), do: {:error, ""}
  defp handle_maps([]), do: {:error, ""}
  defp handle_maps(list) do
    List.first(list)
  end
end
