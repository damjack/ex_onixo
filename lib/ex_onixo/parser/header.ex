defmodule ExOnixo.Parser.Header do
  import SweetXml

  def parse(doc) do
    doc |> xpath(
      ~x"//Header"l,
      sender_name: ~x"./Sender/SenderName/text()",
      send_date_time: ~x"./SentDateTime/text()",
      default_currency_code: ~x"./DefaultCurrencyCode/text()"
    )
  end
end
