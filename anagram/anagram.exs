defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &anagram?(&1, base))
  end

  defp anagram?(word, word2) do
    ordered_letters(word) == ordered_letters(word2) && String.upcase(word) != String.upcase(word2)
  end

  defp ordered_letters(word) do
    word
    |> String.upcase()
    |> String.to_char_list()
    |> Enum.sort()
  end
end
