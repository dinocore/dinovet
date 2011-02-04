module ApplicationHelper
  def error_message
    "<div id='flash-error'>#{h flash[:error]}</div>"
  end

  def notice_message
    "<div id='flash-notice'>#{h flash[:notice]}</div>"
  end
end
