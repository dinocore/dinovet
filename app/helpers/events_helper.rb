module EventsHelper
  def select_tag_for_filter(model)
    options  = model::FILTERS.collect { |k, v| [v[:label], v[:scope]] }
    selected = params[:filter]
    select_tag("filter", options_for_select(options, selected))
  end

  def date_range_tag_for_filter
    value = params[:date_filter] || "Enter a date range"
    text_field_tag "date_filter", value, :class => :date_range_picker
  end
end
