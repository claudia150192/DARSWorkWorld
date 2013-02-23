class WebNumericalResultsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @web_numerical_results = WebNumericalResult.all
    authorize! :manage, @web_numerical_result
  end

  def show
  end
  def new
    @web_numerical_result = WebNumericalResult.new
  end
  def edit
  end
  def create
    @web_numerical_result = WebNumericalResult.new(params[:web_numerical_result])
    if @web_numerical_result.save
      redirect_to(@web_numerical_result, :notice => 'Web Numerical Result was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @web_numerical_result.update_attributes(params[:web_numerical_result])
      redirect_to(@web_numerical_result, :notice => 'Web Numerical Result was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @web_numerical_result.destroy
    redirect_to(web_numerical_results_url)
  end
  
  def help
    render :template => 'situations/_web_numerical_result_help', :layout => false
  end
end
