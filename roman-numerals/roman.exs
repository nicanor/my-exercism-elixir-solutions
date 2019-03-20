defmodule Roman do
  @letters [
    {"M", 1000},
    {"CM", 900},
    {"D", 500},
    {"CD", 400},
    {"C", 100},
    {"XC", 90},
    {"L", 50},
    {"XL", 40},
    {"X", 10},
    {"IX", 9},
    {"V", 5},
    {"IV", 4},
    {"I", 1}
  ]

  def numerals(0), do: ""

  def numerals(number) do
    {roman, arabic} = Enum.find(@letters, &(number >= elem(&1, 1)))
    roman <> numerals(number - arabic)
  end
end
