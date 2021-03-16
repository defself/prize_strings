defmodule PrizeStringsTest do
  use ExUnit.Case
  doctest PrizeStrings

  test "greets the world" do
    assert PrizeStrings.calculate(4) == 43
  end
end
