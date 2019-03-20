defmodule ListOps do
  @spec count(list) :: non_neg_integer
  def count(list) do
    list
    |> reduce(0, fn _, a -> a + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(list) do
    list
    |> reduce([], &[&1 | &2])
  end

  @spec map(list, (any -> any)) :: list
  def map(list, f) do
    list
    |> reverse()
    |> reduce([], &[f.(&1) | &2])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f) do
    list
    |> reverse()
    |> reduce([], &((f.(&1) && [&1 | &2]) || &2))
  end

  @spec append(list, list) :: list
  def append(list_a, list_b) do
    list_a
    |> reverse()
    |> reduce(list_b, &[&1 | &2])
  end

  @spec concat([[any]]) :: [any]
  def concat(list_of_lists) do
    list_of_lists
    |> reverse()
    |> reduce([], &append/2)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc

  def reduce([head | tail], acc, f) do
    reduce(tail, f.(head, acc), f)
  end
end
