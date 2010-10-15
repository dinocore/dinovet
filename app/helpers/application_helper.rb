module ApplicationHelper
  def error_message
    "<div id='flash-error'>#{h flash[:error]}</div>" unless flash[:error].blank?
  end

  def notice_message
    "<div id='flash-notice'>#{h flash[:notice]}</div>" unless flash[:notice].blank?
  end
end
