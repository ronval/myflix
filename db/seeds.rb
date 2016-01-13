# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


batman = Video.create(title:"Batman v Superman", description:"Mighty Heros fighting", small_cover_url:"/tmp/batmanvsuperman.jpg", large_cover_url:"/tmp/monk_large.jpg", category_id: 1 )
Video.create(title:"Starwars: Force Awakens", description:"BEST MOVIE EVERRRRRR", small_cover_url:"/tmp/futurama.jpg", large_cover_url:"/tmp/monk_large.jpg", category_id: 2 )
Video.create(title:"Captain America: Civil War", description:"Mighty Heros fighting", small_cover_url:"/tmp/south_park.jpg", large_cover_url:"/tmp/monk_large.jpg", category_id: 3 )
Video.create(title:"Wonder Woman", description:"Mighty Hero", small_cover_url:"/tmp/wonderwoman.jpg", large_cover_url:"/tmp/monk_large.jpg", category_id: 4 )
Video.create(title:"TMNT", description:"Turtles Power", small_cover_url:"/tmp/monk.jpg", large_cover_url:"/tmp/monk_large.jpg", category_id: 5)



Category.create(category:"Action")
Category.create(category:"Drama")
Category.create(category:"Comic Book")
Category.create(category:"Thriller")
Category.create(category:"Horror")


martin = User.create(email:"martin@gmail.com", password:"123456", full_name:"Martin Valencia")

Review.create(score:5, review_content:"This movie was great", user: martin, video: batman )