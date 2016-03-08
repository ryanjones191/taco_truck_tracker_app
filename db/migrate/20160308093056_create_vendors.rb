class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :username
      t.string :email
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
