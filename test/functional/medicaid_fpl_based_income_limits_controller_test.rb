require 'test_helper'

class MedicaidFplBasedIncomeLimitsControllerTest < ActionController::TestCase
  setup do
    @medicaid_fpl_based_income_limit = medicaid_fpl_based_income_limits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:medicaid_fpl_based_income_limits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create medicaid_fpl_based_income_limit" do
    assert_difference('MedicaidFplBasedIncomeLimit.count') do
      post :create, :medicaid_fpl_based_income_limit => @medicaid_fpl_based_income_limit.attributes
    end

    assert_redirected_to medicaid_fpl_based_income_limit_path(assigns(:medicaid_fpl_based_income_limit))
  end

  test "should show medicaid_fpl_based_income_limit" do
    get :show, :id => @medicaid_fpl_based_income_limit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @medicaid_fpl_based_income_limit.to_param
    assert_response :success
  end

  test "should update medicaid_fpl_based_income_limit" do
    put :update, :id => @medicaid_fpl_based_income_limit.to_param, :medicaid_fpl_based_income_limit => @medicaid_fpl_based_income_limit.attributes
    assert_redirected_to medicaid_fpl_based_income_limit_path(assigns(:medicaid_fpl_based_income_limit))
  end

  test "should destroy medicaid_fpl_based_income_limit" do
    assert_difference('MedicaidFplBasedIncomeLimit.count', -1) do
      delete :destroy, :id => @medicaid_fpl_based_income_limit.to_param
    end

    assert_redirected_to medicaid_fpl_based_income_limits_path
  end
end
