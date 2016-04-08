require 'test_helper'

class StaticsPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Team 13 Project 3 Proto"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | Team 13 Project 3 Proto"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | Team 13 Project 3 Proto"
  end
  
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | Team 13 Project 3 Proto"
  end
  
end
