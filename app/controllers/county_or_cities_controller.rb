class CountyOrCitiesController < ApplicationController
  layout "application"
  load_and_authorize_resource
  
  def index
    @county_or_cities = CountyOrCity.all
    authorize! :manage, @county_or_city
  end

  def show
  end

  def new
    @county_or_city = CountyOrCity.new
  end

  def edit
  end

  def create
    @county_or_city = CountyOrCity.new(params[:county_or_city])
    if @county_or_city.save
      redirect_to(@county_or_city, :notice => 'CountyOrCity was successfully created.') 
    else
      render :action => "new" 
    end
  end

  def update
    if @county_or_city.update_attributes(params[:county_or_city])
      redirect_to(@county_or_city, :notice => 'CountyOrCity was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @county_or_city.destroy
    redirect_to(county_or_cities_url)
  end
end
