defmodule PigLatin do
  @vowels 'aeiouAEIOU'
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()

  def translate(words) do
    words
    |> String.split()
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  def translate_word(<<vowel>> <> rest) when vowel in @vowels, do: <<vowel>> <> rest <> "ay"

  def translate_word("x" <> <<cons>> <> rest) when cons not in @vowels,
    do: "x" <> <<cons>> <> rest <> "ay"

  def translate_word("y" <> <<cons>> <> rest) when cons not in @vowels,
    do: "y" <> <<cons>> <> rest <> "ay"

  def translate_word(phrase) do
    {cons, rest} = split_constants(phrase)
    rest <> cons <> "ay"
  end

  defp split_constants(<<vowel>> <> rest) when vowel in @vowels, do: {"", <<vowel>> <> rest}
  defp split_constants("qu" <> rest), do: {"qu", rest}

  defp split_constants(<<cons>> <> rest) do
    {other_cons, rest} = split_constants(rest)
    {<<cons>> <> other_cons, rest}
  end
end
