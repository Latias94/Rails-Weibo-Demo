require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                 email: "user@invalid",
                                 password: "foo",
                                 password_confirmation: "bar"} }
    end

    assert_template 'users/new' # 提交失败后是否会重新渲染 new 动作
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password: "password",
                                         password_confirmation: "password"} }
    end
    follow_redirect! # 跟踪重定向
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
