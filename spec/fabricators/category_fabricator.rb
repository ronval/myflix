Fabricator(:category) do 
  category {Faker::Lorem.words(1).join("")}
end 