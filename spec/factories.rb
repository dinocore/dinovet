Factory.define :client do |c|
  c.sequence(:first_name) { |n| "first_name_#{n}"         }
  c.sequence(:last_name)  { |n| "last_name_#{n}"          }
  c.sequence(:address_1)  { |n| "address_1_#{n}"          }
  c.sequence(:address_2)  { |n| "address_2_#{n}"          }
  c.sequence(:city)       { |n| "city_#{n}"               }
  c.sequence(:zipcode)    { |n| "zipcode_#{n}"            }
  c.sequence(:phone)      { |n| "phone_#{n}"              }
  c.sequence(:email)      { |n| "email_#{n}@dinocore.net" }
  c.state "New York"
end
