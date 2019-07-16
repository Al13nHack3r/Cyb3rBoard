require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(fname: "Al13n", lname: "Hack3r", nname: "Cyb3r Al13n", email: "al13nhack3r@protonmail.com", password: "Computing19", password_confirmation: "Computing19", bio: "This is my BIO!", web: "www.mysite.com", github: "github.com/Al13nHack3r", discord: "Al13nHack3r#8982")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.fname = " "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.fname = "a" * 51
    assert_not @user.valid?
  end

  test "bio should be present" do
    @user.bio = " "
    assert_not @user.valid?
  end

  test "bio should not be too long" do
    @user.bio = "a" * 501
    assert_not @user.valid?
  end

  test "web should be present" do
    @user.web = " "
    assert_not @user.valid?
  end

  test "web should not be too long" do
    @user.web = "a" * 31
    assert_not @user.valid?
  end

  test "discord should be present" do
    @user.discord = " "
    assert_not @user.valid?
  end

  test "discord should not be too long" do
    @user.discord = "a" * 51
    assert_not @user.valid?
  end

  test "github should be present" do
    @user.github = "  "
    assert_not @user.valid?
  end

  test "github should not be too long" do
    @user.github = "a" * 76
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.lname = " "
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.lname = "a" * 51
    assert_not @user.valid?
  end

  test "nick name should be present" do
    @user.nname = " "
    assert_not @user.valid?
  end

  test "nick name should not be too long" do
    @user.nname = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
