defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(2, &(&1 + 1)) |> Stream.filter(&prime?/1) |> Enum.at(count - 1)
  end

  defp prime?(2), do: true
  defp prime?(n), do: !Enum.any?(2..round(:math.sqrt(n)), &(rem(n, &1) == 0))
end
