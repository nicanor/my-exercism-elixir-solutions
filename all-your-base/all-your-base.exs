defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    digits
    |> Enum.reverse()
    |> Stream.with_index()
    |> Enum.map(&(convert(&1, base_a)))
    |> Enum.sum()
    |> Integer.digits()
    |> Enum.reverse()
    |> Stream.with_index()
    |> Enum.map(&(convert(&1, base_b)))
    |> Enum.sum()
    |> Integer.digits()
  end

  def convert({number, index}, new_base) do
    round(number * :math.pow(new_base,index))
  end
end
