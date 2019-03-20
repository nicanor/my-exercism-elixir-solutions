defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map_join(&count_chars/1)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.replace(~r/(\d*\D)/, "\\g{1}-")
    |> String.split("-", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.map_join(&multiplicate_chars/1)
  end

  defp count_chars([x]), do: x
  defp count_chars(x), do: "#{Enum.count(x)}#{List.first(x)}"

  defp parse(x) when byte_size(x) == 1, do: {1, x}
  defp parse(x), do: Integer.parse(x)

  defp multiplicate_chars({n, x}), do: String.duplicate(x, n)
end
