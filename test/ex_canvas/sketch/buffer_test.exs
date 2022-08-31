defmodule ExCanvas.Sketch.BufferTest do
  use ExCanvas.DataCase

  alias ExCanvas.Sketch.Buffer

  describe "buffer" do
    import ExCanvas.ProjectsFixtures

    test "build/1 build clean buffer" do
      canvas = canvas_fixture()
      buffer = Buffer.build(canvas)

      assert length(buffer.buffer) == 42 * 42
    end

    test "build/1 build fixture 1 Test" do
      canvas = canvas_24x10_fixture()
      rectangle_5x3_fixture(canvas)
      rectangle_10x3_fixture(canvas)

      buffer = Buffer.build(canvas)

      assert to_string(buffer) == ~s[________________________
________________________
___@@@@@________________
___@XXX@__XXXXXXXXXXXXXX
___@@@@@__XOOOOOOOOOOOOX
__________XOOOOOOOOOOOOX
__________XOOOOOOOOOOOOX
__________XOOOOOOOOOOOOX
__________XXXXXXXXXXXXXX
________________________]
    end

    test "build/1 build fixture 2 Test" do
      canvas = canvas_24x10_fixture_2()
      rectangle_7x6_fixture_2(canvas)
      rectangle_8x4_fixture_2(canvas)
      rectangle_5x3_fixture_2(canvas)

      buffer = Buffer.build(canvas)

      assert to_string(buffer) == ~s[______________.......___
______________.......___
______________.......___
OOOOOOOO______.......___
O      O______.......___
O    XXXXX____.......___
OOOOOXXXXX______________
_____XXXXX______________
________________________
________________________]
    end
  end
end
