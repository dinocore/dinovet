module TreatmentCategoriesHelper
  def treatment_select
    select_tag "treatment[category_ids][]", 
            options_for_select(@categories, @treatment.category_ids),
            { :multiple => true, :size => 5, :id => "treatment_categories" }
  end

  def create_treatment_category_link
    link_to image_tag('add.png') + "Create a new category", 
        new_treatment_category_path, :remote => true
  end

  def treatment_category_panel(treatment_category, &block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'treatment-category',
        :title => "Treatment Category",
        :subtitle => treatment_category.name }, 
      &block
  end

  def edit_treatment_category_link(category)
    link_to h(category.name), edit_treatment_category_path(category),
        :remote => true
  end
end
