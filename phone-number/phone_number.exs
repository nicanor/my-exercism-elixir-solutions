defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    raw
    |> String.replace(~r/\p{P}|\s|\+/, "")
    |> Integer.parse()
    |> validate()
  end

  defp validate({number, ""}), do: validate(Integer.digits(number))
  defp validate({_, _}), do: validate("")

  defp validate([1 | rest]) when length(rest) == 10, do: validate(rest)

  defp validate([a, _, _, b, _, _, _, _, _, _] = s) when a > 1 and b > 1, do: Enum.join(s)

  defp validate(_), do: "0000000000"

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    String.slice(number(raw), 0, 3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
  end
end
