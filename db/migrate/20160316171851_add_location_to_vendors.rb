class AddLocationToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :sun_loc, :string
    add_column :vendors, :mon_loc, :string
    add_column :vendors, :tues_loc, :string
    add_column :vendors, :weds_loc, :string
    add_column :vendors, :thurs_loc, :string
    add_column :vendors, :fri_loc, :string
    add_column :vendors, :sat_loc, :string
  end
end
