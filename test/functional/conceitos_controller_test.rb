require 'test_helper'

class ConceitosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get pendentes" do
    get :pendentes
    assert_response :success
  end

  test "should get prontos" do
    get :prontos
    assert_response :success
  end

end
