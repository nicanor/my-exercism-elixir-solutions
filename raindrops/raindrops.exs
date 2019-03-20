defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) when rem(number, 3) != 0 and rem(number, 5) != 0 and rem(number, 7) != 0,
    do: "#{number}"

  def convert(number) do
    ""
    |> maybe_concat(number, 3, "Pling")
    |> maybe_concat(number, 5, "Plang")
    |> maybe_concat(number, 7, "Plong")
  end

  def maybe_concat(string, number, factor, phrase) when rem(number, factor) == 0,
    do: string <> phrase

  def maybe_concat(string, _, _, _), do: string
end
