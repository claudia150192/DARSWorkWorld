class VaMedicaidRatesController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @va_medicaid_rates = VaMedicaidRate.all
    authorize! :manage, @va_medicaid_rate
  end

  def show
  end

  def new
    @va_medicaid_rate = VaMedicaidRate.new
  end

  def edit
  end

  def create
    @va_medicaid_rate = VaMedicaidRate.new(params[:va_medicaid_rate])
    if @va_medicaid_rate.save
      redirect_to(@va_medicaid_rate, :notice => 'VaMedicaidRate was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @va_medicaid_rate.update_attributes(params[:va_medicaid_rate])
      redirect_to(@va_medicaid_rate, :notice => 'VaMedicaidRate was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @va_medicaid_rate.destroy
    redirect_to(va_medicaid_rates_url)
  end
end
