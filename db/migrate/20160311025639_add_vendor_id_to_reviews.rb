class AddVendorIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :vendor_id, :integer
  end
end
