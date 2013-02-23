class FederalPovertyLevelsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @federal_poverty_levels = FederalPovertyLevel.all
    authorize! :manage, @federal_poverty_level
  end

  def show
  end

  def new
    @federal_poverty_level = FederalPovertyLevel.new
  end

  def edit
  end

  def create
    @federal_poverty_level = FederalPovertyLevel.new(params[:federal_poverty_level])
    if @federal_poverty_level.save
      redirect_to(@federal_poverty_level, :notice => 'FederalPovertyLevel was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @federal_poverty_level.update_attributes(params[:federal_poverty_level])
      redirect_to(@federal_poverty_level, :notice => 'FederalPovertyLevel was successfully updated.') 
    else
      render :action => "edit"
    end
  end

  def destroy
    @federal_poverty_level.destroy
    redirect_to(federal_poverty_levels_url)
  end
end
