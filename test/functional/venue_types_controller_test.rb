require 'test_helper'

class VenueTypesControllerTest < ActionController::TestCase
  setup do
    @venue_type = venue_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venue_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venue_type" do
    assert_difference('VenueType.count') do
      post :create, :venue_type => @venue_type.attributes
    end

    assert_redirected_to venue_type_path(assigns(:venue_type))
  end

  test "should show venue_type" do
    get :show, :id => @venue_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @venue_type.to_param
    assert_response :success
  end

  test "should update venue_type" do
    put :update, :id => @venue_type.to_param, :venue_type => @venue_type.attributes
    assert_redirected_to venue_type_path(assigns(:venue_type))
  end

  test "should destroy venue_type" do
    assert_difference('VenueType.count', -1) do
      delete :destroy, :id => @venue_type.to_param
    end

    assert_redirected_to venue_types_path
  end
end
