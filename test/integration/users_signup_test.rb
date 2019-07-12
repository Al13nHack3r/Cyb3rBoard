require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { fname:  "",
                                         lname: "",
                                         nname: "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { fname:  "Al13n",
                                         lname:  "Hack3r",
                                         nname:  "Cyb3r Al13ns",
                                         email: "al13nhack3r@protonmail.com",
                                         password:              "Computing19",
                                         password_confirmation: "Computing19" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end

end
