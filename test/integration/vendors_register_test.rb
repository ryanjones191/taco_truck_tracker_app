require 'test_helper'

class VendorsRegisterTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get register_path
    assert_no_difference 'Vendor.count' do
      post vendors_path, vendor: { username:  "",
                               email: "user@invalid",
                               company: "",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'vendors/new'
  end

  test "valid signup information" do
    get register_path
    assert_difference 'Vendor.count', 1 do
      post_via_redirect vendors_path, vendor: { username:  "Example",
                                            email: "user@example.com",
                                            company: "Smacks",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'vendors/show'
    assert vendor_is_logged_in?
  end
end
