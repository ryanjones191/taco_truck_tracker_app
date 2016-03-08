require 'test_helper'

class VendorSessionsHelperTest < ActionView::TestCase

  def setup
    @vendor = vendors(:stephen)
    vendor_remember(@vendor)
  end

  test "current_vendor returns right vendor when session is nil" do
    assert_equal @vendor, current_vendor
    assert vendor_is_logged_in?
  end

  test "current_vendor returns nil when remember digest is wrong" do
    @vendor.update_attribute(:remember_digest, Vendor.digest(Vendor.new_token))
    assert_nil current_vendor
  end
end