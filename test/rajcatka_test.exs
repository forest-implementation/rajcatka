defmodule RajcatkaTest do
  use ExUnit.Case
  doctest Rajcatka

  test "generate" do
    assert Rajcatka.rajcatka(2, :rand.seed(:exsplus, 1)) == [
             0.5821536519260221,
             0.07758877497339435
           ]
  end

  test "plotek" do
    assert {0, 1} |> Rajcatka.plotek() == 0.5
    assert {0, 2} |> Rajcatka.plotek() == 1
    assert {1, 2} |> Rajcatka.plotek() == 1.5
  end

  test "count_rajcatka" do
    assert Rajcatka.count_rajcatka([0.2, 0.3, 0.5, 0.7], {0, 0.5}) == 2
  end

  def averages(tuple) do
    {0, 1} |> Rajcatka.pulit(tuple)
    |> Enum.map( fn {{s,e}, v} -> {:math.log(1/(e - s))/:math.log(2), length(v)}  end)
    |> Enum.reduce({0,0}, fn {add, n}, {sacc, cacc} -> {sacc+(add*n), cacc+n}   end)
    |> then(fn {nu, de} -> nu/de  end)
  end

  # test "pulit" do
  #   {0, 1} |> Rajcatka.pulit([0.2, 0.51, 0.52, 0.7,0.8,0.81,0.814,0.85,0.9]) |> IO.inspect()
  #   |> Enum.map( fn {{s,e}, v} -> {:math.log(1/(e - s))/:math.log(2), length(v)}  end) |> IO.inspect()
  #   |> Enum.reduce({0,0}, fn {add, n}, {sacc, cacc} -> {sacc+(add*n), cacc+n}   end) |> IO.inspect()
  #   |> then(fn {nu, de} -> nu/de  end) |> IO.inspect()
  # end

  # test "smazat" do
  #   left_child = %TreeNode{value: 2}
  #   right_child = %TreeNode{value: 3, left: %TreeNode{value: 5}}
  #   root = %TreeNode{value: 1, left: left_child, right: right_child}
  #   assert Tree.count_nodes(root) == 4
  # end

  @tag timeout: :infinity
  test "idk" do
     Stream.map((1..3000000), fn _ -> Rajcatka.rajcatka(11) end) |> Enum.map(&averages/1) |> then(fn x -> Enum.sum(x)/length(x) end) |>  IO.inspect
  end
end
