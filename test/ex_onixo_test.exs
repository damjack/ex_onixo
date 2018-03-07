defmodule ExOnixoTest do
  use ExUnit.Case
  doctest ExOnixo

  test "get parsed ONIX" do
    assert ExOnixo.analyze(file) == :tuple
  end
end
