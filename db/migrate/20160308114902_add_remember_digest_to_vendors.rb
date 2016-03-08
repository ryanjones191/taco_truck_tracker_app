class AddRememberDigestToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :remember_digest, :string
  end
end
