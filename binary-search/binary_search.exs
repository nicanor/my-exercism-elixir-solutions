defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """
  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) when is_tuple(numbers) do
    numbers
    |> Tuple.to_list()
    |> Enum.with_index()
    |> do_search(key)
  end

  defp do_search([], _), do: :not_found
  defp do_search([{key, i}], key), do: {:ok, i}
  defp do_search([{_not_key, _i}], _key), do: :not_found

  defp do_search(numbers, key) do
    {left, [{x, i} | right]} = Enum.split(numbers, div(length(numbers), 2))

    cond do
      key == x -> {:ok, i}
      key < x -> do_search(left, key)
      key > x -> do_search(right, key)
    end
  end
end
