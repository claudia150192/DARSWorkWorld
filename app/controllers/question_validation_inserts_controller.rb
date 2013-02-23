class QuestionValidationInsertsController < ApplicationController
  layout "application"
  load_and_authorize_resource

  def index
    @question_validation_inserts = QuestionValidationInsert.all
    
    authorize! :manage, @question_validation_insert
  end

  def show
  
  #  @WebTip = WebTip.find(params[:id])
  # @WebTextResult = WebTextResult.find(params[:id])  
  end

  def new
    @question_validation_inserts = QuestionValidationInsert.new
  end

  def edit
  end

  def create
    @question_validation_insert = QuestionValidationInsert.new(params[:question_validation_insert])
    if @question_validation_insert.save
      redirect_to(@question_validation_insert, :notice => 'Question Validation Insert was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @question_validation_insert.update_attributes(params[:question_validation_insert])
      redirect_to(@question_validation_insert, :notice => 'question validation insert was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @question_validation_insert.destroy
    redirect_to(question_validation_inserts_url)
  end
  
  # def return_name_from_id id  NOt working Review later
  def return_name_from_id
  @question_validation_inserts_sub = QuestionValidationInsert.all
    @return_name_from_id = "teturn from sub"
   
  
  end
  
end
