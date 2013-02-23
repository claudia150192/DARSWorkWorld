class QuestionInsertsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @question_inserts = QuestionInsert.all
    # @WebTextResult = WebTextResult.all
    
    authorize! :manage, @question_insert
  end

  def show
  
  #  @WebTip = WebTip.find(params[:id])
  # @WebTextResult = WebTextResult.find(params[:id])  
  end

  def new
    @question_inserts = QuestionInsert.new
  end

  def edit
  end

  def create
    @question_insert = QuestionInsert.new(params[:question_insert])
    if @question_insert.save
      redirect_to(@question_insert, :notice => 'QuestionInsert was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @question_insert.update_attributes(params[:question_insert])
      redirect_to(@question_insert, :notice => 'question insert was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @question_insert.destroy
    redirect_to(question_inserts_url)
  end
  
  # def return_name_from_id id  NOt working Review later
  def return_name_from_id
  @question_inserts_sub = QuestionInsert.all
    @return_name_from_id = "teturn from sub"
   
  
  end
  
end
