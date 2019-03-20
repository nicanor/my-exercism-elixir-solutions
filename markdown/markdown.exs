defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(text_in_markdown) do
    text_in_markdown
    |> String.split("\n")
    |> Enum.map_join(&process_line/1)
    |> add_missing_tags()
  end

  defp process_line(line) do
    case line do
      "\#\#\#\#\#\# " <> r -> add_tags(r, "h6")
      "\#\#\#\#\# " <> r -> add_tags(r, "h5")
      "\#\#\#\# " <> r -> add_tags(r, "h4")
      "\#\#\# " <> r -> add_tags(r, "h3")
      "\#\# " <> r -> add_tags(r, "h2")
      "\# " <> r -> add_tags(r, "h1")
      "\* " <> r -> add_tags(r, "li")
      _ -> add_tags(line, "p")
    end
  end

  defp add_tags(text, tag_name) do
    "<#{tag_name}>#{text}</#{tag_name}>"
  end

  defp add_missing_tags(text) do
    text
    |> String.replace(~r/__([^\_]*)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_([^\_]*)_/, "<em>\\1</em>")
    |> String.replace(~r/(?!<\/li>)<li>(.*)<\/li>(?!<li>)/, "<ul><li>\\1</li></ul>")
  end
end
