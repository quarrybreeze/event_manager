require 'csv'
require 'erb'

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

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = clean_phonenumber(row[:homephone])
  puts phone
end

