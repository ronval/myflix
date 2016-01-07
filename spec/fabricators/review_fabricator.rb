Fabricator(:review) do 
  review_content {Faker::Lorem.words(4).join(' ')}
  score {(1..5).to_a.sample}
end 