require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Test User", email: "test@email.com",
                     password: "password", password_confirmation: "password")
  end
  
  test "user should be valid" do
    assert @user.valid?
  end
  
  test "user should have a name" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "user should have an email" do
    @user.email = "    "
    assert_not @user.valid?
  end
  
  test "user name less than 48 char" do
    @user.name = "z" * 48 
    assert_not @user.valid?
  end
  
  test "user base email less than 216 char" do 
    @user.email = "z" * 216 + "@example.com"
    assert_not @user.valid?
  end
  
  test "mailer validation should take valid adresses" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
                      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "mailer validation should NOT take invalid adresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
                          foor@bar_baz.com foor@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "user should have unique email" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "user cannot have blank password" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "user password must be 6 or more char" do 
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
end
