defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^\w-]|_/u)
    |> Enum.reduce(%{}, &update_counter/2)
  end

  defp update_counter("", counter), do: counter
  defp update_counter(word, counter), do: Map.update(counter, word, 1, &(&1 +1))
end
