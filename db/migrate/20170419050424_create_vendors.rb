class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.integer :uid, null: false
      t.string :provider, null: false
      t.string :email, null: false
      t.string :username, null: false
      t.timestamps
    end
  end
end
