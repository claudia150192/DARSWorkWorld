class TextResultInsertsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @text_result_inserts = TextResultInsert.all
    # @WebTextResult = WebTextResult.all

    
    
    authorize! :manage, @text_result_insert
  end

  def show
    @WebTextResult = WebTextResult.find(params[:id])
     #@trName1 = [return_name_from_id].to_s + "happy" 
  end

  def new
    @text_result_inserts = TextResultInsert.new
  end

  def edit
  end

  def create
    @text_result_insert = TextResultInsert.new(params[:text_result_insert])
    if @text_result_insert.save
      redirect_to(@text_result_insert, :notice => 'TextResultInsert was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @text_result_insert.update_attributes(params[:text_result_insert])
      redirect_to(@text_result_insert, :notice => 'text result insert was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @text_result_insert.destroy
    redirect_to(text_result_inserts_url)
  end
  
  # def return_name_from_id id  NOt working Review later
  def return_name_from_id
  @text_result_inserts_sub = TextResultInsert.all
    @return_name_from_id = "teturn from sub"
   # @return_name_from_id = WebTextResult.find(:first, :conditions => ['id = ?',  @text_result_inserts_sub.web_text_result_id]).name 
    
    #@return_name_from_id = WebTextResult.find(params[:id]).name 
   # @WebTextResult.find(:first, :conditions => ['id = ?',  id]).name
    #WebTextResult.find(:first, :conditions => ['id = ?',  @text_result_insert.web_text_result_id]).name
  end
  
end
