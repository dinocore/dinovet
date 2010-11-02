module DiagnosisCategoriesHelper
  def diagnosis_select(diagnosis_categories, options = {})
    select_tag :diagnosis_id, option_groups_from_collection_for_select(
                                                          diagnosis_categories,
                                                          :diagnoses,
                                                          :name,
                                                          :id,
                                                          :name), options
  end
end
