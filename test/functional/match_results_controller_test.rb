require 'test_helper'

class MatchResultsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:match_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create match_result" do
    assert_difference('MatchResult.count') do
      post :create, :match_result => { }
    end

    assert_redirected_to match_result_path(assigns(:match_result))
  end

  test "should show match_result" do
    get :show, :id => match_results(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => match_results(:one).to_param
    assert_response :success
  end

  test "should update match_result" do
    put :update, :id => match_results(:one).to_param, :match_result => { }
    assert_redirected_to match_result_path(assigns(:match_result))
  end

  test "should destroy match_result" do
    assert_difference('MatchResult.count', -1) do
      delete :destroy, :id => match_results(:one).to_param
    end

    assert_redirected_to match_results_path
  end
end
