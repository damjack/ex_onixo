defmodule ExOnixo.Helper.ElementYml do
  import SweetXml
  alias ExOnixo.Helper.Tags

  def get_tag(xml, tag, text) do
    xpath(xml, ~x".#{tag}/text()"s)
    |> handle_tag(text)
  end

  defp handle_tag(code, text) do
    Tags.tag30[text][code]
    |> handle_error
  end

  def get_tag21(xml, tag, text) do
    xpath(xml, ~x".#{tag}/text()"s)
    |>handle_tag21(text)
  end

  defp handle_tag21(code, text) do
    Tags.tag21[text][code]
    |> handle_error
  end

   defp handle_error(""), do: {:error, ""}
   defp handle_error(nil), do: {:error, ""}
   defp handle_error(text), do: text
end
