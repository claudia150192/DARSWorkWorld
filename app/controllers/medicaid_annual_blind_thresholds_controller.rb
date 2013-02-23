class MedicaidAnnualBlindThresholdsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @medicaid_annual_blind_thresholds = MedicaidAnnualBlindThreshold.all
    authorize! :manage, @medicaid_annual_blind_threshold
  end

  def show
  end

  def new
    @medicaid_annual_blind_threshold = MedicaidAnnualBlindThreshold.new
  end

  def edit
  end

  def create
    @medicaid_annual_blind_threshold = MedicaidAnnualBlindThreshold.new(params[:medicaid_annual_blind_threshold])
    if @medicaid_annual_blind_threshold.save
      redirect_to(@medicaid_annual_blind_threshold, :notice => 'MedicaidAnnualBlindThreshold was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @medicaid_annual_blind_threshold.update_attributes(params[:medicaid_annual_blind_threshold])
      redirect_to(@medicaid_annual_blind_threshold, :notice => 'MedicaidAnnualBlindThreshold was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @medicaid_annual_blind_threshold.destroy
    redirect_to(medicaid_annual_blind_thresholds_url)
  end
end
