class AddDefaultValueToStatusAttribute < ActiveRecord::Migration
  def up
  change_column :vendors, :status, :boolean, :default => false
end

def down
  change_column :vendors, :status, :boolean, :default => nil
end
end
