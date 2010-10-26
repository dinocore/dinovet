Then /^I should see the (.*) form$/ do |name|
  name.gsub!(' ', '_')
  page.should have_css("form.#{name}")
end

Given /^the following (.*):$/ do |type, objects|
  type  = type.gsub(' ', '_').downcase.singularize
  klass = type.classify.constantize

  objects.hashes.each do |object_hash|

    safe_hash = object_hash.reject { |k, v| k =~ /\./ }
    object = klass.new(Factory.attributes_for(type).merge(safe_hash))
    
    # Handle embedded documents defined by <document>.<field> strings
    object_hash.each do |key, val|
      keys = key.split('.')
      if keys.count > 1
        embedded_type   = keys.first.singularize.gsub(' ', '_').downcase
        embedded_klass  = embedded_type.classify.constantize
        embedded_hash   = Factory.attributes_for(embedded_type)
        embedded_hash.merge!({ keys.second => val })
        object.send(keys.first.to_sym).build(embedded_hash)
      end
    end

    object.save!
  end
end

Then /^I should see the following (.*):$/ do |type, expected_objects_table|
  type = type.gsub(' ', '_').downcase
  expected_objects_table.diff!(tableish("table.#{type} tr", "td,th"))
end
