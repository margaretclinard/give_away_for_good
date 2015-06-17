Fabricator(:post) do
  category    { Faker::Lorem.words(4) }
  description { Faker::Lorem.paragraph(2) }
  date_posted "2015-06-16"
  deadline    "2015-06-16"
end