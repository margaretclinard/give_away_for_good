Fabricator(:user) do
  name   { Faker::Name.name }
  email  { Faker::Internet.email }
  password              "password1"
  password_confirmation "password1"
  company { Faker::Company.name}
  street1 { Faker::Address.street_address }
  street2 { Faker::Address.secondary_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  zip { Faker::Address.zip }
end