class WebTipInsertsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @web_tip_inserts = WebTipInsert.all
    # @WebTextResult = WebTextResult.all
    
    authorize! :manage, @web_tip_insert
  end

  def show
  
  #  @WebTip = WebTip.find(params[:id])
  # @WebTextResult = WebTextResult.find(params[:id])  
  end

  def new
    @web_tip_inserts = WebTipInsert.new
  end

  def edit
  end

  def create
    @web_tip_insert = WebTipInsert.new(params[:web_tip_insert])
    if @web_tip_insert.save
      redirect_to(@web_tip_insert, :notice => 'WebTipInsert was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @web_tip_insert.update_attributes(params[:web_tip_insert])
      redirect_to(@web_tip_insert, :notice => 'web tip insert was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @web_tip_insert.destroy
    redirect_to(web_tip_inserts_url)
  end
  
  # def return_name_from_id id  NOt working Review later
  def return_name_from_id
  @web_tip_inserts_sub = WebTipInsert.all
    @return_name_from_id = "teturn from sub"
   
  
  end
  
end
