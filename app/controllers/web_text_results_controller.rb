class WebTextResultsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @web_text_results = WebTextResult.all
    authorize! :manage, @web_text_result
  end

  def show
  end
  def new
    @web_text_result = WebTextResult.new
  end
  def edit
  end
  def create
    @web_text_result = WebTextResult.new(params[:web_text_result])
    if @web_text_result.save
      redirect_to(@web_text_result, :notice => 'Web Text Result was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @web_text_result.update_attributes(params[:web_text_result])
      redirect_to(@web_text_result, :notice => 'Web Text Result was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @web_text_result.destroy
    redirect_to(web_text_results_url)
  end
  
  def help
    #render :template => 'situations/_web_numerical_result_help', :layout => false
  end
end
