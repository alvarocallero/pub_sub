defmodule GenserverExampleTest do
  use ExUnit.Case
  doctest GenserverExample

  test "greets the world" do
    assert GenserverExample.hello() == :world
  end
end
