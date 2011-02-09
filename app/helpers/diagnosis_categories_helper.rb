module DiagnosisCategoriesHelper
  def diagnosis_select
    select_tag "diagnosis[category_ids][]", 
            options_for_select(@categories, @diagnosis.category_ids),
            { :multiple => true, :size => 5, :id => "diagnosis_categories" }
  end

  def create_diagnosis_category_link
    link_to image_tag('add.png') + "Create a new category", 
        new_diagnosis_category_path, :remote => true
  end

  def diagnosis_category_panel(diagnosis_category, &block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'diagnosis-category',
        :title => "Category",
        :subtitle => diagnosis_category.name }, 
      &block
  end

  def edit_diagnosis_category_link(category)
    link_to h(category.name), edit_diagnosis_category_path(category),
        :remote => true
  end
end
