class WhiskeyFinder
  def initialize(whiskey_params = {})
    @query     = whiskey_params.fetch(:query) { '' }
    @taste     = whiskey_params.fetch(:taste) { 0 }
    @color     = whiskey_params.fetch(:color) { 0 }
    @smokiness = whiskey_params.fetch(:smokiness) { 0 }
  end

  def search
    whiskey_scope
      .where(
        'title ILIKE ? OR description ILIKE ?',
        "%#{query}%", "%#{query}%"
      )
      .minimum_color(color.to_i)
      .minimum_smokiness(smokiness.to_i)
      .minimum_taste(taste.to_i)
  end

  def self.search(whiskey_params = {})
    new(whiskey_params).search
  end

  private

  attr_reader :color, :query, :smokiness, :taste

  def whiskey_scope
    Whiskey.all
  end
end
