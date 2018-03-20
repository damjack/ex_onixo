defmodule ExOnixo.Helper.Date do
  import Timex

  def to_date(code, datetime) do
    if String.length(datetime) !== 0 do
      case code do
        "00" ->
          parse!(datetime, "%Y%m%d", :strftime)
        "01" ->
          parse!(datetime, "%Y%m", :strftime)
        "05" ->
          parse!(datetime, "%Y", :strftime)
        "13" ->
          parse!(datetime, "%Y%m%dT%H%M", :strftime)
        "14" ->
          parse!(datetime, "%Y%m%dT%H%M%S", :strftime)
        _ ->
          parse!(datetime, "%Y%m%d", :strftime)
      end
    end
  end
end
