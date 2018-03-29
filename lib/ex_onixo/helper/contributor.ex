defmodule ExOnixo.Helper.Contributor do
  @moduledoc false

  defp contributor_role(code) do
    cond do
      author(code) ->
        "author"
      illustrator(code) ->
        "illustrator"
      translator(code) ->
        "translator"
      prefacer(code) ->
        "prefacer"
      curator(code) ->
        "curator"
      true ->
        "other"
    end
  end

  defp author(code), do: code in ["A01", "A02", "A03", "A04", "A05", "A06", "A07", "A08", "A09", "A10", "A11", "A31"]
  defp illustrator(code), do: code in ["A12", "A13", "A36", "A39", "A40", "A41", "A47"]
  defp translator(code), do: code in ["B06", "B08", "B10"]
  defp prefacer(code), do: code in ["A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21", "A22", "A23"]
  defp curator(code), do: code in ["A32", "A37", "A38", "B01", "B05", "B09", "B11", "B12", "B13", "B19", "B20", "B24"]

  def contributors(list) do
    unless Enum.empty?(list) do
      list
        |> Enum.map(fn contributor ->
            %{
              role: contributor_role(contributor[:contributor_role_code]),
              sequence_number: contributor[:sequence_number],
              person_name: contributor[:person_name],
              person_name_inverted: contributor[:person_name_inverted]
            }
          end)
        |> Enum.to_list
    end
  end
end
