class MedicaidAnnualThresholdsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @medicaid_annual_thresholds = MedicaidAnnualThreshold.all
    authorize! :manage, @medicaid_annual_threshold
  end

  def show
  end

  def new
    @medicaid_annual_threshold = MedicaidAnnualThreshold.new
  end

  def edit
  end

  def create
    @medicaid_annual_threshold = MedicaidAnnualThreshold.new(params[:medicaid_annual_threshold])
    if @medicaid_annual_threshold.save
      redirect_to(@medicaid_annual_threshold, :notice => 'MedicaidAnnualThreshold was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @medicaid_annual_threshold.update_attributes(params[:medicaid_annual_threshold])
      redirect_to(@medicaid_annual_threshold, :notice => 'MedicaidAnnualThreshold was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @medicaid_annual_threshold.destroy
    redirect_to(medicaid_annual_thresholds_url)
  end
end
