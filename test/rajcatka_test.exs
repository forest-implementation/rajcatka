defmodule RajcatkaTest do
  use ExUnit.Case
  doctest Rajcatka

  test "generate" do
    assert Rajcatka.rajcatka(:rand.seed(:exsplus, 1), 2) == [
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

  test "pulit" do
    {0, 1} |> Rajcatka.pulit([0.2, 0.3, 0.5, 0.7]) |> IO.inspect()
  end

  test "smazat" do
    left_child = %TreeNode{value: 2}
    right_child = %TreeNode{value: 3, left: %TreeNode{value: 5}}
    root = %TreeNode{value: 1, left: left_child, right: right_child}
    assert Tree.count_nodes(root) == 4
  end
end
