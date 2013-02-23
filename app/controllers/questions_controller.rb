class QuestionsController < ApplicationController
  layout "application"
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  def index
   # @questions = Question.all(:order => "group_id ASC, name ASC")
    @questions = Question.all(:order => sort_column + " " + sort_direction)
    authorize! :manage, @question
  end

  def show
  end

  def new
    @question = Question.new
    @help_topics = Help.all
  end

  def edit
    @help_topics = Help.all
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to(@question, :notice => 'Successfully created question.')
    else
      render :action => "new"
    end
  end

  def update
    if @question.update_attributes(params[:question])
      redirect_to(@question, :notice => 'Question updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    
    @Insert = QuestionInsert.find(:all, :conditions => ['question_id = ?',  @question.id])
     if !(@Insert.blank?)
       @Insert.each do |question_insert| 
         question_insert.delete
        end        
     end
    
     @Insert2 = QuestionValidationInsert.find(:all, :conditions => ['question_id = ?',  @question.id])
      if !(@Insert2.blank?)
        @Insert2.each do |question_validation_insert| 
          question_validation_insert.delete
         end        
      end
      
      
    @question.destroy
    flash[:notice] = "Question deleted."
    redirect_to(questions_url)
  end
   
   #added by Bobc  May be moved later s oit applies to all index files
   private
   
   def sort_column
     Question.column_names.include?(params[:sort]) ? params[:sort] : "name"
   end
   
   def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
   end
end
