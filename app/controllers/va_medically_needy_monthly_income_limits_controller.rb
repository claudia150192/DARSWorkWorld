class VaMedicallyNeedyMonthlyIncomeLimitsController < ApplicationController
#va_medically_needy_monthly_income_limits
#VaMedicallyNeedyMonthlyIncomeLimits
  layout "application"
  load_and_authorize_resource

  def index
    @va_medically_needy_monthly_income_limits = VaMedicallyNeedyMonthlyIncomeLimit.all
    authorize! :manage, @va_medically_needy_monthly_income_limit
  end

  def show
  end

  def new
    @va_medically_needy_monthly_income_limit = VaMedicallyNeedyMonthlyIncomeLimit.new
  end

  def edit
  end

  def create
    @va_medically_needy_monthly_income_limit = VaMedicallyNeedyMonthlyIncomeLimit.new(params[:va_medically_needy_monthly_income_limit])
    if @va_medically_needy_monthly_income_limit.save
      redirect_to(@va_medically_needy_monthly_income_limit, :notice => 'VaMedicallyNeedyMonthlyIncomeLimit was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @va_medically_needy_monthly_income_limit.update_attributes(params[:va_medically_needy_monthly_income_limit])
      redirect_to(@va_medically_needy_monthly_income_limit, :notice => 'VaMedicallyNeedyMonthlyIncomeLimit was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @va_medically_needy_monthly_income_limit.destroy
    redirect_to(va_medically_needy_monthly_income_limits_url)
  end
end
