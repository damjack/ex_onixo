defmodule ExOnixo.Helper.ElementYml do
  import SweetXml
  alias ExOnixo.Helper.Tags

  def get_tag(xml, tag, text) do
    xpath(xml, ~x".#{tag}/text()"s)
    |> handle_tag(text)
  end

  defp handle_tag(code, text) do
    Tags.tag30[text][code]
  end

  def get_tag21(xml, tag, text) do
    xpath(xml, ~x".#{tag}/text()"s)
    |>handle_tag21(text)
  end

  defp handle_tag21(code, text) do
    Tags.tag21[text][code]
  end
end
