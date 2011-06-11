require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get results" do
    get :results
    assert_response :success
  end

end
