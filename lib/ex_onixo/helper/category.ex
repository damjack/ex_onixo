defmodule ExOnixo.Helper.Category do
  @moduledoc false

  def cce(list) do
    unless list === nil do
      if Map.has_key?(list, :subjects) do
        unless Enum.empty?(list[:subjects]) do
          list[:subjects]
          |> Enum.map(fn subject ->
              if subject[:subject_scheme_identifier] === "SoggettoCce" do
                %{
                    code: subject[:subject_code],
                    text: subject[:subject_heading_text]
                  }
              end
            end)
          |> Enum.reject(&is_nil/1)
        end
      end
    end
  end
end
