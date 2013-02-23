class WebCalcsController < ApplicationController
  layout "application"
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @web_calcs = WebCalc.all
    authorize! :manage, @web_calc
    respond_with(@web_calcs)
  end

  def show
  end

  def new
    @web_calc = WebCalc.new
  end

  def edit
  end

  def create
    @web_calc = WebCalc.new(params[:web_calc])
    if @web_calc.save
      redirect_to(@web_calc, :notice => 'Web Calc was successfully created.')
    else
      render :action => "new" 
    end
  end

  def update
    if @web_calc.update_attributes(params[:web_calc])
      redirect_to(@web_calc, :notice => 'Web Calc was successfully updated.')  
    else
      render :action => "edit"
    end
  end

  def destroy
    @web_calc.destroy
    redirect_to(web_calcs_url)
  end
end
