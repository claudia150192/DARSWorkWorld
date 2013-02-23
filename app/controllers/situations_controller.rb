class SituationsController < ApplicationController
  layout 'situations'
  
  before_filter :require_user
  before_filter :require_case
  before_filter :initialize_session_and_manager
  before_filter :check_mode
  before_filter :parent_groups

  def index
    # right now just display a link to start a new situation
  end
  
  # Start a new what-if situation 
  # Reinitialize the session hash of the answers
  # With the default answers for the first group already stored depending on the display mode
  def new
    @case = Case.find_by_id @case_id
    if @case.has_unfinished_situation?
      redirect_to :back, :notice=>'You cannot add a situation while your case has other situations that are incomplete'
#    This was added on 4/6/2012  
    elsif(@case.situations.count > 4)
     #this is faster but pops up a screen overlay flash[:notice] = "You cannot add more than 4 what-ifs"
     # This was taking a long time redirect_to :back, :notice=>'You cannot add more than 4 what-ifs'  
     redirect_to :back, :notice=>'You cannot add more than 4 what-ifs'  
#      
    elsif(@case.situations.count == 1)
      build_what_if(@case, @case.current_situation)
      if(params[:redirect_to] && params[:redirect_to] == 'all_inputs')
        redirect_to(cases_all_inputs_path(:case_id=>@case_id))
      else
        redirect_to(edit_case_situation_path(:case_id=>@case_id, :id=>@situation.id))
      end
    else 
      respond_to do |format|
        format.js {render :layout=>nil, :content_type => 'text/html' }
        format.html
      end
    end
  end

  def create
    @case = Case.find_by_id(@case_id)
    parent = @case.situations.find_by_id(params[:parent_id])
    build_what_if(@case, parent)
    if(params[:redirect_to] && params[:redirect_to] == 'all_inputs')
      redirect_to(cases_all_inputs_path(:case_id=>@case_id))
    else
      redirect_to(edit_case_situation_path(:case_id=>@case_id, :id=>@situation.id))
    end
  end

  # Display the group's questions
  def show
    @group ||= QuestionGroup.find(params[:group_id])
    unless @group.blank?
      session[:situation] = @manager.setup_session_for_group @group, @mode, current_user
      @group.validates? session[:situation]
      session[:situation] = @manager.update_web_tips(@group)
    end
  end
  
  def continue
    session[:situation] = @manager.add_group_answers_to_session params
    @group = QuestionGroup.find(params[:group_id])
    if @group.validates? session[:situation]
      @situation.save_answers(@manager.situation)
    end
    @group = @situation.get_current_group
    if @group.nil?
      @situation.complete!
      redirect_to :action=>"numeric_results", :case_id=>@case.id
    else
      flash[:notice]="Situation saved"
      redirect_to :action=> "edit", :case_id=> @case_id, :id=>@situation.id, :group_id=>@group.id
    end
  end

  # needed for the all-inputs page, to allow saving answers from multiple groups in bulk
  def accept_all
    session[:situation] = @manager.add_all_answers_to_session params
    @situation.save_answers(@manager.situation)
    @group = @situation.get_current_group
    if(@group.nil?)
      @situation.complete!
    end
    @situation[:groups] = {}
    respond_to do |format|
      format.html{
         flash[:notice]='Situation saved'
         redirect_to cases_all_inputs_path(@case.id) 
      }
      format.json { render :json => @situation }
    end
  end

  # If next group does not exist, go to numerical results
  def accept
    session[:situation] = @manager.add_group_answers_to_session params
    @group = QuestionGroup.find(params[:group_id])
    if @group.validates? @situation
      @situation.save_answers(@manager.situation)
      ### TODO: It might be in the get_next_displayable_question method that we're having the lag; likewise the fact that we're using session[:situation] vice @situation...
      question = @group.get_next_displayable_question(session[:situation])
      if !question.blank?
        session[:situation] = @manager.add_default_question_answer question, current_user
      end
    end
    session[:situation] = @manager.update_web_tips(@group) unless @group.blank?
    respond_to do |format|
       format.html {
         if @group.has_validation_errors?
           flash[:error] = 'There have been some errors in your answers'
           render :action=>'edit'
         else
           flash[:notice]='Situation saved'
           redirect_to :action=> "edit", :case_id=> @case_id, :id=>@situation.id, :group_id=>@group.id
         end
       }
       format.js {
         render :partial => "group", :object => @group, :layout => false
       }
    end
  end
  
  # edit just one questions
  def edit_one
    @question = Question.find_by_name params[:question_name]
    render :partial=>"one", :layout=>false  
  end


  # open situation and show first group of questions
  def edit
    if @situation.case.has_unfinished_situation? && @situation.completed
      flash[:notice] = 'Cannot edit a situation if you have not finished all the others in the case'
      redirect_to :action=>"edit", :case_id=>@case.id, :id=>@case.situation_in_progress.id
    end

    @group = QuestionGroup.find_by_id(params["group_id"])
    #@group = @situation.get_current_group if @group.nil?
    @parent = @group.parent unless @group.blank?
    if @group.blank?
      @parent = QuestionGroup.first_displayable_parent_group @situation
      @group = @parent.fetch_first_displayable_child @situation
    end
    unless @group.blank?
      @group.validates? session[:situation]
      @situation = @manager.setup_session_for_group(@group, @situation, session[:situation][:mode], @current_user)
      @situation = @manager.update_web_tips(@group)
    end
    @continue = @situation.answered_all_questions_in?(@group) || @situation.mode == WWWebSessionManager::MODES[:group]
    session[:situation] = @situation
    render :action => "edit", :group_id => @group.id
  end
  
  # Display numerical results
  def numeric_results
    @groups = WebNumericalResultsGroup.all :order => "web_numerical_results_groups.order ASC"
    respond_to do |format|
      format.html
      format.pdf do
        pdf = NumericResultsPdf.new(@case, @groups, view_context)
        send_data pdf.render, filename: pdf.file_name, type: "application/pdf", disposition: "inline"
      end
    end
  end
 
  def graphic_results
    @charts = Chart.all
  end

 # show text results
  def text_results
    @groups = WebTextResultsGroup.all :order => "web_text_results_groups.order ASC"
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TextResultsPdf.new(@case, @groups, view_context)
        send_data pdf.render, filename: pdf.file_name, type: "application/pdf", disposition: "inline"
      end
    end
  end 
  
  # override situation answers
  def update
    @current_situation = Situation.find_by_id(@manager.get_situation_id)
    @current_situation.save_answers @manager.situation
    redirect_to :action => "edit", :case_id => @case.id, :id => @current_situation.id
  end
  
  def update_nav
    @group = QuestionGroup.find(params[:group_id])
    respond_to do |format|
      format.js { render :partial => "group_navigation", :object => @nav_parents, :locals => { :group => @group }, :layout => false }
    end
  end
  
  def delete
    @situation=Situation.find(params[:id])
    @group = @situation.get_current_group
  end

  def destroy
    @case = Case.find(params[:case_id])
    @situation = Situation.find(params[:id])
    @situation.destroy
    flash[:notice] = "Situation deleted"
    redirect_to :action=>"edit", :case_id=>@case.id, :id=>@case.current_situation.id

  end
private 
 def parent_groups
   @nav_parents = QuestionGroup.nav_parent_groups 
 end

 def setup_manager
   @manager = WWWebSessionManager.new(@situation, current_user)
 end
 
 def check_mode
   if !params[:mode].blank?
      @mode = params[:mode]
   elsif !current_user.mode_preference.blank?
     @mode = current_user.mode_preference
   elsif !session[:situation][:mode].blank?
      @mode = session[:situation][:mode]
  # else
  #   @mode = WWWebSessionManager::MODES[:one_at_a_time]
   end
   if @mode != session[:situation][:mode] && !@mode.blank?
    session[:situation][:mode] = @mode
    current_user.mode_preference = @mode
    current_user.save
   end
   if @mode != @situation.mode
     @situation.mode = @mode
     @situation.save
   end
 end
 
 def initialize_session_and_manager
   if params[:id]
     @situation = fetch_situation_by_id params[:id]
   else
     @situation = @case.current_situation
   end
   setup_manager
   unless session[:situation].blank? || session[:situation].id == @situation
     @manager.initialize_group_hash
   end
   session[:situation] = @situation
 end

 def require_case
   @case_id = params[:case_id]
   if(@case_id.blank?)
     redirect_to cases_path,  :error=>"You cannot work on a situation without a case"
     return
   end
   @case = Case.find(@case_id)
 end

 def fetch_situation_by_id id
   id = id.to_i
   if session[:situation].blank? || session[:situation].id != id
     s = Situation.includes(:answers => [{:question=>:group}]).find_by_id id
   else
     session[:situation]
   end
 end

 def build_what_if kase, parent
    @situation = @case.build_what_if(parent)
    if !@case.save
      flash[:error] = @case.errors[:situations][0]
      @situation = @case.current_situation
    end
 end
end

