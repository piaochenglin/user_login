class CreateHouses < ActiveRecord::Migration[5.1]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :type
      t.integer :guest_count
      t.integer :bedroom_count
      t.integer :bed_count
      t.integer :bathroom_count
      t.text :introduce
      t.string :map_url
      t.time :checkin_from
      t.time :checkout_to
      t.integer :active
      t.datetime :deleted_at
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
