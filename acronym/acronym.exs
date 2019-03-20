defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/[A-Z]|\W([a-z])/, string)
    |> Enum.map(&List.last/1)
    |> Enum.join()
    |> String.upcase()
  end
end
