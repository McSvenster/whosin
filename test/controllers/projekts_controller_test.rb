require 'test_helper'

class ProjektsControllerTest < ActionController::TestCase
  setup do
    @projekt = projekts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projekts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create projekt" do
    assert_difference('Projekt.count') do
      post :create, projekt: { description: @projekt.description, enddate: @projekt.enddate, jpissue: @projekt.jpissue, startdate: @projekt.startdate, title: @projekt.title }
    end

    assert_redirected_to projekt_path(assigns(:projekt))
  end

  test "should show projekt" do
    get :show, id: @projekt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @projekt
    assert_response :success
  end

  test "should update projekt" do
    patch :update, id: @projekt, projekt: { description: @projekt.description, enddate: @projekt.enddate, jpissue: @projekt.jpissue, startdate: @projekt.startdate, title: @projekt.title }
    assert_redirected_to projekt_path(assigns(:projekt))
  end

  test "should destroy projekt" do
    assert_difference('Projekt.count', -1) do
      delete :destroy, id: @projekt
    end

    assert_redirected_to projekts_path
  end
end
