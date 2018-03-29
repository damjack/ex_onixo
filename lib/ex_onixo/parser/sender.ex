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
    |> Enum.fetch!(0)
  end

  defp name(nil), do: ""
  defp name(params) do
    if params[:sender_name] === "" do
      params[:sender_value]
    else
      params[:sender_name]
    end
  end

  def convert(map) do
    %{
      name: name(map),
      code: Slugger.slugify(name(map) |> String.downcase)
    }
  end
end
