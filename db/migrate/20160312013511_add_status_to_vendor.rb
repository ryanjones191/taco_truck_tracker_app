class AddStatusToVendor < ActiveRecord::Migration
  def change
    add_column :vendors, :status, :boolean
  end
end
