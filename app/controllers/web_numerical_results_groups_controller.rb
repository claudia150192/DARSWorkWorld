class WebNumericalResultsGroupsController < ApplicationController
  layout "application"
  load_and_authorize_resource
  
  def index
    @web_numerical_results_groups = WebNumericalResultsGroup.all
    authorize! :manage, @web_numerical_results_group
  end

  def show
  end
  def new
    @web_numerical_results_group = WebNumericalResultsGroup.new
  end

  def edit
  end

  def create
    @web_numerical_results_group = WebNumericalResultsGroup.new(params[:web_numerical_results_group])
    if @web_numerical_results_group.save
      redirect_to(@web_numerical_results_group, :notice => 'Web Numerical Results Group was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def update
    if @web_numerical_results_group.update_attributes(params[:web_numerical_results_group])
      redirect_to(@web_numerical_results_group, :notice => 'Web Numerical Results Group was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @web_numerical_results_group.destroy
    redirect_to(web_numerical_results_groups_url)
  end
end
