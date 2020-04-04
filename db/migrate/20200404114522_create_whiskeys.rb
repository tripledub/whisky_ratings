class CreateWhiskeys < ActiveRecord::Migration[6.0]
  def change
    create_table :whiskeys do |t|
      t.string :title
      t.text :description
      t.integer :taste
      t.integer :color
      t.integer :smokiness

      t.timestamps
    end
    add_index :whiskeys, :title
    add_index :whiskeys, :description
  end
end
