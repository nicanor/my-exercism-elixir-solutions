defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &translate/1)
  end

  defp translate(?A), do: ?U
  defp translate(?C), do: ?G
  defp translate(?G), do: ?C
  defp translate(?T), do: ?A
end
