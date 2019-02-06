class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address1, null: false
      t.string :address2
      t.string :landmark, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :pincode, null: false

      t.timestamps
    end
  end
end
