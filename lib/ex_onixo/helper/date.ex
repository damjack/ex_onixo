defmodule ExOnixo.Helper.Date do
  import SweetXml
  import Timex

  def to_date(code, datetime) do
    if String.length(datetime) !== 0 do
      case code do
        "00" ->
          convert_strftime(datetime)
        "01" ->
          datetime |> String.slice(0..5) |> parse!("%Y%m", :strftime)
        "05" ->
          datetime |> String.slice(0..3) |> parse!("%Y", :strftime)
        "13" ->
          parse!(datetime, "%Y%m%dT%H%M", :strftime)
        "14" ->
          parse!(datetime, "%Y%m%dT%H%M%S", :strftime)
        _ ->
          convert_strftime(datetime)
      end
    end
  end

  def to_date_without_code(xml) do
    code = get_code(xml, %{tag: "/DateFormat", inline: "Date/@dateformat"})
    datetime = xpath(xml, ~x"./Date/text()"s)
    if String.length(datetime) !== 0 do
      case code do
        "00" ->
          convert_strftime(datetime)
        "01" ->
          datetime |> String.slice(0..5) |> parse!("%Y%m", :strftime)
        "05" ->
          datetime |> String.slice(0..3) |> parse!("%Y", :strftime)
        "13" ->
          parse!(datetime, "%Y%m%dT%H%M", :strftime)
        "14" ->
          parse!(datetime, "%Y%m%dT%H%M%S", :strftime)
        _ ->
          convert_strftime(datetime)
      end
    end
  end

  defp get_code(xml, opts) do
    inline = xpath(xml, ~x"./#{opts[:inline]}"s)
    if String.length(inline) === 0 do
      xpath(xml, ~x".#{opts[:tag]}/text()"s)
    else
      inline
    end
  end

  defp convert_strftime(string) do
    if string |> String.length > 10 do
      String.slice(string, 0..9) |> parse!("%Y-%m-%d", :strftime)
    else
      String.slice(string, 0..7) |> parse!("%Y%m%d", :strftime)
    end
  end

  def check_and_parse(datetext) do
    if String.length(datetext) !== 0 do
      case String.length(datetext) do
        8 ->
          parse!(datetext, "%Y%m%d", :strftime)
        6 ->
          parse!(datetext, "%Y%m", :strftime)
        4 ->
          parse!(datetext, "%Y", :strftime)
        _ ->
          datetext
      end
    end
  end
end
