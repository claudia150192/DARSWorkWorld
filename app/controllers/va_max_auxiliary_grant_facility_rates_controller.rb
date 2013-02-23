class VaMaxAuxiliaryGrantFacilityRatesController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @va_max_auxiliary_grant_facility_rates = VaMaxAuxiliaryGrantFacilityRate.all
    authorize! :manage, @va_max_auxiliary_grant_facility_rate
  end

  def show
  end

  def new
    @va_max_auxiliary_grant_facility_rate = VaMaxAuxiliaryGrantFacilityRate.new
  end

  def edit
  end

  def create
    @va_max_auxiliary_grant_facility_rate = VaMaxAuxiliaryGrantFacilityRate.new(params[:va_max_auxiliary_grant_facility_rate])
    if @va_max_auxiliary_grant_facility_rate.save
      redirect_to(@va_max_auxiliary_grant_facility_rate, :notice => 'VaMaxAuxiliaryGrantFacilityRate was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @va_max_auxiliary_grant_facility_rate.update_attributes(params[:va_max_auxiliary_grant_facility_rate])
      redirect_to(@va_max_auxiliary_grant_facility_rate, :notice => 'VaMaxAuxiliaryGrantFacilityRate was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @va_max_auxiliary_grant_facility_rate.destroy
    redirect_to(va_max_auxiliary_grant_facility_rates_url)
  end
end
