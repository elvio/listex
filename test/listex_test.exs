defmodule ListexTest do
  use ExUnit.Case

  test "single item" do
    list = [
      %{text: "One", indent: 0}
    ]

    assert Listex.convert_list(list) == "<ol><li>One</li></ol>"
  end

  test "two items in the same level" do
    list = [
      %{text: "One", indent: 0},
      %{text: "Two", indent: 0}
    ]

    assert Listex.convert_list(list) == "<ol><li>One</li><li>Two</li></ol>"
  end

  test "three items in two different levels" do
    list = [
      %{text: "One", indent: 0},
      %{text: "Two", indent: 0},
      %{text: "Three", indent: 1}
    ]

    assert Listex.convert_list(list) == "<ol><li>One</li><li>Two<ol><li>Three</li></ol></li></ol>"
  end

  test "fourt items in three different levels" do
    list = [
      %{text: "One", indent: 0},
      %{text: "Two", indent: 0},
      %{text: "Three", indent: 1},
      %{text: "Four", indent: 2}
    ]

    assert Listex.convert_list(list) ==
             "<ol><li>One</li><li>Two<ol><li>Three<ol><li>Four</li></ol></li></ol></li></ol>"
  end

  test "deals with challenge case" do
    list = [
      %{text: "One", indent: 0},
      %{text: "Two", indent: 0},
      %{text: "Alpha", indent: 1},
      %{text: "I", indent: 2},
      %{text: "II", indent: 2},
      %{text: "Three", indent: 0}
    ]

    assert Listex.convert_list(list) ==
             "<ol><li>One</li><li>Two<ol><li>Alpha<ol><li>I</li><li>II</li></ol></li></ol></li><li>Three</li></ol>"
  end
end
