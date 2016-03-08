require 'test_helper'

class VendorsLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @vendor = vendors(:stephen)
  end

  test "vendor login with invalid information" do
    get vendor_login_path
    assert_template 'vendor_sessions/new'
    post vendor_login_path, session: { email: "", password: "" }
    assert_template 'vendor_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "vendor login with valid information followed by logout" do
    get vendor_login_path
    post vendor_login_path, session: { email: @vendor.email, password: 'password' }
    assert vendor_is_logged_in?
    assert_redirected_to @vendor
    follow_redirect!
    assert_template 'vendors/show'
    assert_select "a[href=?]", vendor_login_path, count: 0
    assert_select "a[href=?]", vendor_logout_path
    assert_select "a[href=?]", vendor_path(@vendor)
    delete vendor_logout_path
    assert_not vendor_is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", vendor_login_path
    assert_select "a[href=?]", vendor_logout_path,      count: 0
    assert_select "a[href=?]", vendor_path(@vendor), count: 0
  end

  test "vendor_login with remembering" do
    vendor_log_in_as(@vendor, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "vendor_login without remembering" do
    vendor_log_in_as(@vendor, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
