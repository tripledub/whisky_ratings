class Whiskey < ApplicationRecord
  validates :title, presence: true

  scope :minimum_color, ->(color) { where('color >= ?', color) }
  scope :minimum_taste, ->(taste) { where('taste >= ?', taste) }
  scope :minimum_smokiness, ->(smokiness) { where('smokiness >= ?', smokiness) }
end
