require 'test_helper'

class ChefsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get chefs_new_url
    assert_response :success
  end

end
