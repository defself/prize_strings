defmodule PrizeStrings do
  @moduledoc """
  A particular school offers cash rewards to children with good attendance and punctuality.
  If they are absent for three consecutive days or late on more than one occasion then they forfeit their prize.

  During an n-day period a trinary string is formed for each child consisting of L's (late), O's (on time), and A's (absent).

  Although there are eighty-one trinary strings for a 4-day period that can be formed, exactly forty-three strings would lead to a prize:

  ```
  OOOO OOOA OOOL OOAO OOAA OOAL OOLO OOLA OAOO OAOA
  OAOL OAAO OAAL OALO OALA OLOO OLOA OLAO OLAA AOOO
  AOOA AOOL AOAO AOAA AOAL AOLO AOLA AAOO AAOA AAOL
  AALO AALA ALOO ALOA ALAO ALAA LOOO LOOA LOAO LOAA
  LAOO LAOA LAAO
  ```
  How many "prize" strings exist over a 30-day period?
  """

  @grades ~w[L O A]

  @doc """
  iex> PrizeStrings.calculate(1)
  3
  iex> PrizeStrings.calculate(2)
  8
  iex> PrizeStrings.calculate(3)
  19
  iex> PrizeStrings.calculate(4)
  43
  # iex> PrizeStrings.calculate(30)
  # ~S[¯\_(ツ)_/¯]
  """
  def calculate(days) do
    students(days)
    |> Enum.count
  end

  @doc """
  iex> PrizeStrings.decent?(~w[L O O L])
  false
  iex> PrizeStrings.decent?(~w[A A A O])
  false
  iex> PrizeStrings.decent?(~w[A A L A])
  true
  iex> PrizeStrings.decent?(~w[L O O O])
  true
  """
  def decent?(student) do
    cond do
      student |> Enum.count(&(&1 == "L")) > 1 -> false
      student |> Enum.join |> String.contains?("AAA") -> false
      true -> true
    end
  end

  defp students(0), do: [[]]

  defp students(days) do
    for head <- @grades,
        tail when tail != [false] <- students(days - 1) do
      if (combo = [head | tail]) |> decent? do
        combo
      else
        [false]
      end
    end
    |> Enum.filter(&(&1 != [false]))
  end
end
