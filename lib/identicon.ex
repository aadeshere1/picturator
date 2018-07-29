defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> color_picker
    |> gridify
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def color_picker(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def gridify(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    # |> Enum.map(fn x -> mirror_row(x) end)
    |> Enum.map(&mirror_row/1)
  end

  def mirror_row(row) do
    [f, s | _tail] = row
    row ++ [s, f]
  end
end
