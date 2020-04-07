require 'csv'

ratings = (1..5).to_a
CSV.parse(File.read("#{File.dirname(__FILE__)}/seeds/whiskeys.csv"), headers: true).each do |row|
  Whiskey.create(
    {
      title: row['name'],
      description: row['description'],
      taste: ratings.sample,
      color: ratings.sample,
      smokiness: ratings.sample
    }
  )
end

