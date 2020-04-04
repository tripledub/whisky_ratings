require 'csv'


CSV.parse(File.read("#{File.dirname(__FILE__)}/seeds/whiskeys.csv"), headers: true).each do |row|
  Whiskey.create({ title: row['name'], description: row['description'] })
end

