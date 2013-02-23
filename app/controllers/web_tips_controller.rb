class WebTipsController < ApplicationController
  layout "application"
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  def index
    # @question_groups = QuestionGroup.all(:order => "question_groups.order ASC, parent_id ASC, name ASC")
    #Note this does sort the index page but does not sort the web tips on the questions screen.
    @question_groups = WebTip.all(:order => sort_column + " " + sort_direction)
    @web_tips = WebTip.all(:order => sort_column + " " + sort_direction)
 #   @web_tips = WebTip.all
    authorize! :manage, @web_tip
  end

  def show
  end

  def new
    @web_tip = WebTip.new
  end

  def edit
  end

  def create
    @web_tip = WebTip.new(params[:web_tip])

    if @web_tip.save
      redirect_to(@web_tip, :notice => 'Web Tip was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @web_tip.update_attributes(params[:web_tip])
      redirect_to(@web_tip, :notice => 'Web Tip was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
    #note to Bob Is this where to put code that deletes associated web_tip_inserts?
    @Insert = WebTipInsert.find(:all, :conditions => ['web_tip_id = ?',  @web_tip.id])
     if !(@Insert.blank?)
       @Insert.each do |tip_insert| 
         tip_insert.delete
        end        
     end
    @web_tip.destroy
    redirect_to(web_tips_url)
  end
end

private
 
 def sort_column
   WebTip.column_names.include?(params[:sort]) ? params[:sort] : "workbook_order"
 end

  def sort_direction
   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
  end