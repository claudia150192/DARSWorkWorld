class WebTextResultsGroupsController < ApplicationController
  layout "application"
  load_and_authorize_resource
  
  def index
    @web_text_results_groups = WebTextResultsGroup.all
    authorize! :manage, @web_text_results_group
  end

  def show
  end
  def new
    @web_text_results_group = WebTextResultsGroup.new
  end

  def edit
  end

  def create
    @web_text_results_group = WebTextResultsGroup.new(params[:web_text_results_group])
    if @web_text_results_group.save
      redirect_to(@web_text_results_group, :notice => 'Web Text Results Group was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def update
    if @web_text_results_group.update_attributes(params[:web_text_results_group])
      redirect_to(@web_text_results_group, :notice => 'Web Text Results Group was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @web_text_results_group.destroy
    redirect_to(web_text_results_groups_url)
  end
end
