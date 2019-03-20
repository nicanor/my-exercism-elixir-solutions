defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.to_charlist()
    |> Enum.filter(&(&1 in '()[]{}'))
    |> scan([])
  end

  defp scan([], ys), do: Enum.empty?(ys)
  defp scan([x | xs], ys) when x in '([{', do: scan(xs, [x | ys])
  defp scan([x | xs], [y | ys]) when [y, x] in ['()', '[]', '{}'], do: scan(xs, ys)
  defp scan(_, _), do: false
end
