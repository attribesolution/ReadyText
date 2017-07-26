# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

# Create Country
Country.create(name: "United States of America",code: "USA",phone_code: "+1")
Country.create(name: "Canada",code: "CA",phone_code: "+1")
Country.create(name: "United Kingdom",code: "UK",phone_code: "+44")
Country.create(name: "Pakistan",code: "PK",phone_code: "+92")
