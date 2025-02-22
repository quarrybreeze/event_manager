require 'csv'
require 'erb'

def date_to_hour(dateTime)
  date_object = DateTime.strptime(dateTime, '%m/%d/%Y %k:%M')
  hour = date_object.hour
end

def date_to_day(dateTime)
  date_object = DateTime.strptime(dateTime, '%m/%d/%Y %k:%M')
  day = date_object.day
end

def date_to_year(dateTime)
  date_object = DateTime.strptime(dateTime, '%m/%d/%Y %k:%M')
  year = date_object.year
end

def date_to_month(dateTime)
  date_object = DateTime.strptime(dateTime, '%m/%d/%Y %k:%M')
  month = date_object.month
end

def date_to_weekday(dateTime)
  date_object = DateTime.strptime(dateTime, '%m/%d/%Y %k:%M')
  weekday = date_object.wday
end

def clean_phonenumber(phonenumber)
  phonenumber = phonenumber.to_s.tr('^0-9', '')
  if phonenumber.length < 10
    phonenumber = '0000000000'
  elsif phonenumber.length == 10
    phonenumber
  elsif phonenumber.length == 11
    if phonenumber.chr == "1"
      phonenumber.delete_prefix("1")
    else
      phonenumber = '0000000000'
    end
  elsif phonenumber.length > 11
    phonenumber = '0000000000'
  end
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)


#validate phone numbers
puts "Name & Number"
contents.each do |row|
  id = row[0]
  name = row[:first_name] + " " + row[:last_name]
  phone = clean_phonenumber(row[:homephone])
  puts "#{name} #{phone}"
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)



#Time Targeting
popular_time_array = []

puts "Time Targeting"
contents.each do |row|
  hour = date_to_hour(row[:regdate])
  popular_time_array = popular_time_array.push(hour)
end

popular_time_hash = popular_time_array.reduce(Hash.new(0))  do |result, time|
  result[time] += 1
  result
end

popular_times = popular_time_hash.sort_by {|key, value| value}.to_h

p popular_times

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

#Weekday Targeting
popular_weekday_array = []

puts "Weekday Targeting"
contents.each do |row|
  weekday = date_to_weekday(row[:regdate])
  popular_weekday_array = popular_weekday_array.push(weekday)
end

popular_weekday_hash = popular_weekday_array.reduce(Hash.new(0)) do |result, weekday|
  result[weekday] += 1
  result
end

popular_weekdays = popular_weekday_hash.sort_by {|key, value| value}.to_h

p popular_weekdays