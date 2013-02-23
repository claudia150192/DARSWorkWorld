class QuestionGroupsController < ApplicationController
  layout "application"
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  
  def index
    @question_groups = QuestionGroup.all(:order => sort_column + " " + sort_direction)

    authorize! :manage, @question_group
  end

  def show
  end

  def new
    @question_group = QuestionGroup.new
  end

  def edit
  end

  def create
    @question_group = QuestionGroup.new(params[:question_group])
    if @question_group.save
      redirect_to(@question_group, :notice => 'Successfully created question group.')
    else
      render :action => "new"
    end
  end

  def update
    if @question_group.update_attributes(params[:question_group])
      redirect_to(@question_group, :notice => 'Question group updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @question_group.destroy
    flash[:notice] = "Question group deleted."
    redirect_to(question_groups_url)
  end
  
  private
   
   def sort_column
     QuestionGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
   end
  
    def sort_direction
     %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
    end 
end
