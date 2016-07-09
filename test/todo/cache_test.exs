defmodule Todo.CacheTest do
  use ExUnit.Case

  alias Todo.Cache

  setup do
    list = %{name: "Home", items: []}
    Cache.save(list)
    {:ok, list: list}
  end

  test ".save adds a list to the ETS table" do
    info = :ets.info(Cache)
    assert info[:size] == 1
  end

  test ".find gets list from ETS table", %{list: list} do
    assert Cache.find(list.name) == list
  end

  test ".clear clears all objects from ETS table", %{list: list} do
    Cache.clear
    refute Cache.find(list.name)
  end
end