defmodule ExOnixo.Helper.Identifier do
  @moduledoc false

  def isbn(list) do
    res = list
      |> Enum.map(fn record ->
          if record[:product_id_type] === "Isbn13" do
            record[:id_value]
          end
        end)
      |> Enum.reject(&is_nil/1)
    if Enum.count(res) !== 0 do
      Enum.fetch!(res, 0)
    else
      ExOnixo.Helper.Identifier.ean(list)
    end
  end

  def ean(list) do
    if list do
      res = list
        |> Enum.map(fn record ->
            if record[:product_id_type] === "Gtin13" do
              record[:id_value]
            end
          end)
        |> Enum.reject(&is_nil/1)
      if Enum.count(res) !== 0 do
        Enum.fetch!(res, 0)
      end
    end
  end
end
