module ApplicationHelper

  def format_datetime_for_dashboard(datetime)
    datetime.strftime("%b %e, %Y @ %l:%M %p")
    rescue
      ""
  end

end
