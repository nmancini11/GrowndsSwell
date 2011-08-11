require 'test_helper'

class SwellsControllerTest < ActionController::TestCase
  setup do
    @swell = swells(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:swells)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create swell" do
    assert_difference('Swell.count') do
      post :create, :swell => @swell.attributes
    end

    assert_redirected_to swell_path(assigns(:swell))
  end

  test "should show swell" do
    get :show, :id => @swell.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @swell.to_param
    assert_response :success
  end

  test "should update swell" do
    put :update, :id => @swell.to_param, :swell => @swell.attributes
    assert_redirected_to swell_path(assigns(:swell))
  end

  test "should destroy swell" do
    assert_difference('Swell.count', -1) do
      delete :destroy, :id => @swell.to_param
    end

    assert_redirected_to swells_path
  end
end
