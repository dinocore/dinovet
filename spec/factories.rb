Factory.define :client do |c|
  c.sequence(:first_name) { |n| "first_name_#{n}"         }
  c.sequence(:last_name)  { |n| "last_name_#{n}"          }
  c.sequence(:address_1)  { |n| "address_1_#{n}"          }
  c.sequence(:address_2)  { |n| "address_2_#{n}"          }
  c.sequence(:city)       { |n| "city_#{n}"               }
  c.sequence(:zipcode)    { |n| "zipcode_#{n}"            }
  c.sequence(:email)      { |n| "email_#{n}@dinocore.net" }
  c.state                 "New York"
  c.phone_numbers         { [Factory.build(:phone_number)] }
end

Factory.define :phone_number do |p|
  p.sequence(:type)       { |n| "type#{n}"       }
  p.sequence(:number)     { |n| "%010d" % n.to_s }
end

Factory.define :patient do |p|
  p.sequence(:name)       { |n| "name#{n}" }
end
