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
  iex> PrizeStrings.calculate(4)
  43
  # iex> PrizeStrings.calculate(30)
  # "¯\_(ツ)_/¯"
  """
  def calculate(days) do
    PrizeStrings.students(days)
    |> Enum.reduce(0, fn (comb, acc) ->
      if PrizeStrings.is_decent(comb) do
        acc + 1
      else
        acc
      end
    end)
  end

  @doc """
  iex> PrizeStrings.is_decent("LOOL")
  false
  iex> PrizeStrings.is_decent("OOOO")
  true
  iex> PrizeStrings.is_decent("LOOO")
  true
  iex> PrizeStrings.is_decent("AAAO")
  false
  """
  def is_decent(student) do
    cond do
      ~r/L/   |> Regex.scan(student) |> Enum.count() > 1 -> false
      ~r/AAA/ |> Regex.scan(student) |> Enum.count() > 0 -> false
      true -> true
    end
  end

  @doc """
  iex> PrizeStrings.students(1)
  ["L", "O", "A"]
  iex> PrizeStrings.students(2)
  ["LL", "LO", "LA", "OL", "OO", "OA", "AL", "AO", "AA"]
  iex> PrizeStrings.students(4) |> Enum.count
  81
  # iex> PrizeStrings.students(30) |> Enum.count
  # "¯\_(ツ)_/¯"
  """
  def students(days) do
    @grades
    |> Permutations.shuffle(days)
    |> Enum.map(&Enum.join(&1))
  end
end
