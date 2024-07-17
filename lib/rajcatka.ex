defmodule Rajcatka do
  @moduledoc """
  Documentation for `Rajcatka`.
  """

  def rajcatka(n\\2, _\\:rand.seed(:exsplus, :os.timestamp())), do: 1..n |> Enum.map(fn _ -> :rand.uniform end)#{:rand.uniform, :rand.uniform}

  def plotek({min, max}), do: (max-min)/2 + min

  def in_range?(number, {a,b}) do
    if number >= a and number < b, do: 1, else: 0
  end

  def count_rajcatka(arr, range), do: count_rajcatka(arr, range, 0)
  def count_rajcatka([], _, count), do: count
  def count_rajcatka([rajce|tail], range, count), do: count_rajcatka(tail, range, count+in_range?(rajce, range))

  #def evaluate(rajcatka, 0) when len(rajcatka) == 1, do:
  def halfrange({min, max}), do: [{min, plotek({min,max})}, {plotek({min,max}), max}]


  def pulit(init_range, rajcatka, acc\\%{}, functionacc\\[], depth\\0) do
    [left, right] = halfrange(init_range)
    leftrajcatka = rajcatka |> Enum.filter(fn rajce -> in_range?(rajce, left) == 1 end)
    rightrajcatka = rajcatka |> Enum.filter(fn rajce -> in_range?(rajce, right) == 1 end)

    case {leftrajcatka |> Enum.count > 1, rightrajcatka |> Enum.count > 1, functionacc} do
      {true, true, f} -> pulit(left, leftrajcatka, acc, [fn end_acc, end_facc -> pulit(right, rightrajcatka, end_acc, end_facc, depth+1) end] ++ f, depth+1)
      {false, true, f} -> pulit(right, rightrajcatka, Map.merge(acc,%{left => leftrajcatka, }), f, depth+1)
      {true, false, f} -> pulit(left, leftrajcatka, Map.merge(acc,%{right => rightrajcatka, }), f, depth+1)
      {false, false, [h|t]} -> h.(Map.merge(acc,%{right => rightrajcatka, left => leftrajcatka, }), t)
      {false, false, []} -> Map.merge(acc,%{right => rightrajcatka, left => leftrajcatka ,})

    end
  end
end

defmodule TreeNode do
  defstruct value: nil, left: nil, right: nil
end

defmodule Tree do
  def count_nodes(tree), do: count_nodes(tree, 0, [])
  defp count_nodes(nil, acc, []), do: acc
  defp count_nodes(nil, acc, [h|t]), do: h.(acc, t)

  defp count_nodes(%TreeNode{left: left, right: right}, acc, acc2), do:
    count_nodes(left, acc+1, [fn end_acc, end_acc2 -> count_nodes(right, end_acc, end_acc2) end] ++ acc2)
end
