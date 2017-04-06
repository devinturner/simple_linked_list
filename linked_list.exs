defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {0, nil, nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {elem(list, 0) + 1, elem, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    elem(list, 0)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    elem(list, 0) == 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    cond do
      empty?(list) -> {:error, :empty_list}
      true -> {:ok, elem(list, 1)}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    cond do
      empty?(list) -> {:error, :empty_list}
      true -> {:ok, elem(list, 2)}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    cond do
      empty?(list) -> {:error, :empty_list}
      true -> {:ok, elem(list, 1), elem(list, 2)}
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    _from_list(Enum.reverse(list), new)
  end

  defp _from_list([], list), do: list
  defp _from_list([h|t], list) do
    _from_list(t, push(list, h))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    _to_list(list, [])
  end

  defp _to_list({0, _value, _list}, acc), do: acc
  defp _to_list({_length, value, list}, acc) do
    _to_list(list, acc ++ [value])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    _reverse(pop(list), new)
  end

  defp _reverse({0, _value, nil}, new_list), do: new_list
  defp _reverse({_length, value, tail}, new_list) do
    _reverse(tail, push(new_list, value))
  end
end
