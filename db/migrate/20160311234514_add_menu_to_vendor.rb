class AddMenuToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :menu1, :string
    add_column :vendors, :menu2, :string
  end
end
