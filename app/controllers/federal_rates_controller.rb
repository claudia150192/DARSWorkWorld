class FederalRatesController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @federal_rates = FederalRate.all
    authorize! :manage, @federal_rate
  end

  def show
  end

  def new
    @federal_rate = FederalRate.new
  end

  def edit
  end

  def create
    @federal_rate = FederalRate.new(params[:federal_rate])
    if @federal_rate.save
      redirect_to(@federal_rate, :notice => 'FederalRate was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @federal_rate.update_attributes(params[:federal_rate])
      redirect_to(@federal_rate, :notice => 'FederalRate was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @federal_rate.destroy
    redirect_to(federal_rates_url)
  end
end
