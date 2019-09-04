defmodule Listex do
  def convert_list([]) do
    "<ol></ol>"
  end

  def convert_list(list) do
    "<ol>#{do_convert_list(list)}</ol>"
  end

  defp do_convert_list(list) do
    convert_items(list, nil)
  end

  defp convert_items([], indent) do
    close_missing(indent) <> "</li>"
  end

  defp convert_items([%{text: text, indent: indent} | tail], nil) do
    "<li>#{text}" <> convert_items(tail, indent)
  end

  defp convert_items([%{text: text, indent: indent} | tail], past_indent) do
    result =
      cond do
        indent == past_indent -> "</li><li>#{text}"
        indent > past_indent -> "<ol><li>#{text}"
        indent < past_indent -> close_missing(past_indent - indent) <> "</li><li>#{text}"
      end

    result <> convert_items(tail, indent)
  end

  defp close_missing(diff) when diff <= 0 do
    ""
  end

  defp close_missing(diff) do
    1..diff
    |> Enum.map(fn _x -> "</li></ol>" end)
    |> Enum.join()
  end
end
