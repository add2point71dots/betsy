class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.integer :uid
      t.string :provider
      t.string :email
      t.string :username
      t.timestamps
    end
  end
end
