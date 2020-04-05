class UpdateWhiskeysChangeDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_default :whiskeys, :taste, 0
    change_column_default :whiskeys, :smokiness, 0
    change_column_default :whiskeys, :color, 0
  end
end
