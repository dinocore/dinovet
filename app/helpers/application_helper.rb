module ApplicationHelper
  def error_message
    "<div id='flash-error'>#{h flash[:error]}</div>"
  end

  def notice_message
    "<div id='flash-notice'>#{h flash[:notice]}</div>"
  end

  def custom_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(record_or_name_or_array,
      *(args << options.merge(:builder => CustomFormBuilder)), &proc)
  end
end

class CustomFormBuilder < ActionView::Helpers::FormBuilder
  def diagnosis_category_select(categories)
    @template.grouped_collection_select @object_name, :diagnosis_id, categories,
              :diagnoses, :name, :id, :name, {}, :size => 10
  end
end
