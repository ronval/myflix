# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Video.create(title:"Batman v Superman", description:"Mighty Heros fighting", small_cover_url:"/tmp/batmanvsuperman.jpg" )
Video.create(title:"Starwars: Force Awakens", description:"BEST MOVIE EVERRRRRR", small_cover_url:"/tmp/starwars.jpg" )
Video.create(title:"Captain America: Civil War", description:"Mighty Heros fighting", small_cover_url:"/tmp/civilwar.jpg" )
Video.create(title:"Wonder Woman", description:"Mighty Hero", small_cover_url:"/tmp/wonderwoman.jpg" )
Video.create(title:"TMNT", description:"Turtles Power", small_cover_url:"/tmp/tmnt.jpg")

