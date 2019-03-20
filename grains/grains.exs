defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number < 1 or number > 64 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end

  def square(number) do
    {:ok, do_square(number)}
  end

  defp do_square(number) do
    round(:math.pow(2, number - 1))
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, do_square(65) - 1}
  end
end
