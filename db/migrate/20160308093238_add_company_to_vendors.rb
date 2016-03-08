class AddCompanyToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :company, :string
  end
end
