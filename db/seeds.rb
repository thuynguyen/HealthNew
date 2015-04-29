# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
# Service.destroy_all
User.create(:email => "bson@gmail.com", password: "1234qwer", password_confirmation: "1234qwer")
# services = {"Kham Thai" => 60, "Sieu Am Thuong" => 80, "Sieu Am Mau" => 150, "Tuyen Giap" => 80}
# services.keys.each do |name|
# 	Service.create(name: name, price: services[name])
# end