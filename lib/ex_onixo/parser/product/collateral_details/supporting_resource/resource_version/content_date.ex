defmodule ExOnixo.Parser.Product.CollateralDetail.SupportingResource.ResourceVersion.ContentDate do
  import SweetXml

  def parse_recursive(xml) do
    SweetXml.xpath(xml, ~x"./ContentDate"l)
    |> Enum.map(fn content_date ->
        %{
          content_date_role: xpath(content_date, ~x"./ContentDateRoleCode/text()"s),
          date: ExOnixo.Helper.Date.to_date(xpath(content_date, ~x"./Date/@dateformat"s), xpath(content_date, ~x"./ContentDate/Date/text()"s)),
          date_text: xpath(content_date, ~x"./ContentDate/Date/text()"s),
        }
      end)
    |> Enum.to_list
  end
end
