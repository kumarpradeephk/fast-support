class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.integer :gender, null: false
      t.string :password_digest, null:false
      t.references :address
      t.string :auth_token
      t.string :otp
      t.boolean :verified, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end
end
