Fabricator(:video) do 
  title {Faker::Book.title}
  description {Faker::Lorem.sentence(3)}
end 