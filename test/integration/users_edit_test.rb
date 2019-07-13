require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { fname:  "",
                                              lname:  "",
                                              nname:  "",
                                              email: "al13nhack3r@protonmail",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    fname  = "Al13n"
    lname  = "Hack3r"
    nname  = "Cyb3r Al13ns"
    email = "al13nhack3r@protonmail.com"
    patch user_path(@user), params: { user: { fname:  fname,
                                              lname:  lname,
                                              nname:  nname,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal fname,  @user.fname
    assert_equal lname,  @user.lname
    assert_equal nname,  @user.nname
    assert_equal email,  @user.email
  end

end
