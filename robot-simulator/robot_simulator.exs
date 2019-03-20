defmodule RobotSimulator do
  defmodule Robot do
    use GenServer

    def init(robot) do
      {:ok, robot}
    end

    def handle_cast(:left, {dir, pos}) do
      {:noreply, {left(dir), pos}}
    end

    def handle_cast(:right, {dir, pos}) do
      {:noreply, {right(dir), pos}}
    end

    def handle_cast(:advance, {dir, pos}) do
      {:noreply, {dir, advance(dir, pos)}}
    end

    def handle_call(:direction, _, {dir, pos}) do
      {:reply, dir, {dir, pos}}
    end

    def handle_call(:position, _, {dir, pos}) do
      {:reply, pos, {dir, pos}}
    end

    defp left(dir) do
      case dir do
        :north -> :west
        :east -> :north
        :south -> :east
        :west -> :south
      end
    end

    defp right(dir) do
      dir
      |> left()
      |> left()
      |> left()
    end

    defp advance(dir, {x, y}) do
      case dir do
        :north -> {x, y + 1}
        :east -> {x + 1, y}
        :south -> {x, y - 1}
        :west -> {x - 1, y}
      end
    end
  end

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @directions [:north, :east, :south, :west]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(dir \\ :north, pos \\ {0, 0})

  def create(dir, _pos) when dir not in @directions do
    {:error, "invalid direction"}
  end

  def create(dir, {x, y}) when is_integer(x) and is_integer(y) do
    {:ok, robot} = GenServer.start_link(Robot, {dir, {x, y}})
    robot
  end

  def create(_dir, _pos) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions = String.to_charlist(instructions)

    cond do
      Enum.all?(instructions, &(&1 in [?L, ?R, ?A])) ->
        Enum.each(instructions, &instruction(&1, robot))
        robot

      true ->
        {:error, "invalid instruction"}
    end
  end

  defp instruction(?L, robot), do: GenServer.cast(robot, :left)
  defp instruction(?R, robot), do: GenServer.cast(robot, :right)
  defp instruction(?A, robot), do: GenServer.cast(robot, :advance)

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    GenServer.call(robot, :direction)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    GenServer.call(robot, :position)
  end
end
