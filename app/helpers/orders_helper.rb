module OrdersHelper

  def get_deliver_time(deliver_time)

    case deliver_time
    when 1 then
      return "8-12"
    when 2 then
      return "12-14"
    when 3 then
      return "14-16"
    when 4 then
      return "16-18"
    when 5 then
      return "18-20"
    when 6 then
      return "20-21"
    else
      return ""
    end

  end

end
