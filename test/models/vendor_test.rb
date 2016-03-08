require 'test_helper'

class VendorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @vendor = Vendor.new(username: "Example", email: "user@example.com", company: "Stuff",
                              password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @vendor.valid?
  end

  test "username should be present" do
    @vendor.username = "     "
    assert_not @vendor.valid?
  end

  test "email should be present" do
    @vendor.email = "     "
    assert_not @vendor.valid?
  end

  test "username should not be too long" do
    @vendor.username = "a" * 51
    assert_not @vendor.valid?
  end

  test "email should not be too long" do
    @vendor.email = "a" * 244 + "@example.com"
    assert_not @vendor.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @vendor.email = valid_address
      assert @vendor.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @vendor.email = invalid_address
      assert_not @vendor.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_vendor = @vendor.dup
    duplicate_vendor.email = @vendor.email.upcase
    @vendor.save
    assert_not duplicate_vendor.valid?
  end

  test "password should be present (nonblank)" do
    @vendor.password = @vendor.password_confirmation = " " * 6
    assert_not @vendor.valid?
  end

  test "password should have a minimum length" do
    @vendor.password = @vendor.password_confirmation = "a" * 5
    assert_not @vendor.valid?
  end

  test "vendor_authenticated? should return false for a vendor with nil digest" do
    assert_not @vendor.vendor_authenticated?('')
  end
end
