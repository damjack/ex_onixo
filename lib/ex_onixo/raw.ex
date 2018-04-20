defmodule ExOnixo.Raw do
  @moduledoc false

  def raw_xml(xml_tree) do
    build_raw_xml(xml_tree, "")
  end

  defp build_raw_xml([], xml), do: xml
  defp build_raw_xml(string, xml) when is_binary(string), do: string <> xml

  defp build_raw_xml(tuple, xml) when is_tuple(tuple),
    do: build_raw_xml([tuple], xml)

  defp build_raw_xml([string | tail], xml) when is_binary(string) do
    build_raw_xml(tail, xml <> string)
  end

  defp build_raw_xml([{type, attrs, children} | tail], xml) do
    build_raw_xml(tail, xml <> tag_for(type, attrs, children))
  end

  defp tag_attrs(attr_list) do
    attr_list
    |> Enum.reduce("", &build_attrs/2)
    |> String.trim()
  end

  defp tag_with_attrs(type, [], children), do: "<#{type}" <> close_open_tag(type, children)

  defp tag_with_attrs(type, attrs, children) do
    "<#{type} #{tag_attrs(attrs)}" <> close_open_tag(type, children)
  end

  defp close_open_tag(_type, _), do: ">"
  defp close_end_tag(type, _), do: "</#{type}>"

  defp build_attrs({attr, value}, attrs), do: ~s(#{attrs} #{attr}="#{value}")
  defp build_attrs(attr, attrs), do: "#{attrs} #{attr}"

  defp tag_for(type, attrs, children) do
    tag_with_attrs(type, attrs, children) <>
      build_raw_xml(children, "") <> close_end_tag(type, children)
  end
end
