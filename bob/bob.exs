defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) ->
        "Fine. Be that way!"

      shouting?(input) && asking_a_question?(input) ->
        "Calm down, I know what I'm doing!"

      shouting?(input) ->
        "Whoa, chill out!"

      asking_a_question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp silence?(input) do
    String.trim(input) == ""
  end

  defp shouting?(input) do
    has_any_letter?(input) && String.upcase(input) == input
  end

  defp asking_a_question?(input) do
    String.ends_with?(input, "?")
  end

  defp has_any_letter?(input) do
    String.match?(input, ~r/[^\W\d]/)
  end
end
