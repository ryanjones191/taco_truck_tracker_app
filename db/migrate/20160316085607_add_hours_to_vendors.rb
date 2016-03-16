class AddHoursToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :sun_open, :string
    add_column :vendors, :sun_close, :string
    add_column :vendors, :mon_open, :string
    add_column :vendors, :mon_close, :string
    add_column :vendors, :tues_open, :string
    add_column :vendors, :tues_close, :string
    add_column :vendors, :weds_open, :string
    add_column :vendors, :weds_close, :string
    add_column :vendors, :thurs_open, :string
    add_column :vendors, :thurs_close, :string
    add_column :vendors, :fri_open, :string
    add_column :vendors, :fri_close, :string
    add_column :vendors, :sat_open, :string
    add_column :vendors, :sat_close, :string
  end
end
