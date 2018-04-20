defmodule ExOnixo.Parser.Sender do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.stream_tags(xml, [:Sender, :SenderName, :SentDateTime], discard: [:Sender, :SenderName, :SentDateTime])
      |> Stream.map(fn {_, doc} ->
          %{
              sender_name: xpath(doc, ~x"//SenderName/text()"s),
              sender_value: xpath(doc, ~x"//Sender/SenderIdentifier/IDValue/text()"s),
              sender_date: xpath(doc, ~x"//SentDateTime/text()"s)
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
