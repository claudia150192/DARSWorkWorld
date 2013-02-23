class CasesController < ApplicationController
#  require 'ruby-debug'
  
  layout 'application'
  load_and_authorize_resource
  before_filter :require_user
  def index
    direction = params[:dir]
    if(['asc','desc'].include?(direction) == false)
      direction = 'desc'
    end
    @reverse_sort = direction == 'desc' ? 'asc' : 'desc'
    if @current_user.admin?
      @cases = Case.find(:all, :conditions=>{:type=>nil}, :order=>"updated_at #{direction}")
    else
      @cases = @current_user.cases(:order=>"updated_at #{direction}").where(:type=>nil) | @current_user.shared_cases(:order=>"updated_at #{direction}")
      @cases.sort! {|a,b| b.updated_at <=> a.updated_at}
      @cases
    end
  end

  def show
  end

  def new
    @case = Case.new
   respond_to do |format|
      format.js {render :layout=>nil, :content_type => 'text/html' }
      format.html
    end
  end

  def edit
    #debugger
    respond_to do |format|
      format.js { render :layout=>nil, :content_type=>'text/html'}
      format.html
    end
  end


  def save_as
    respond_to do |format|
      format.js {render :layout=>nil, :content_type=>'text/html'}
      format.html
    end
  end

  def copy_to
    kase = params[:case] || params[:shared_case]
    @new = @case.save_as kase[:name], @current_user
    if @new.save
      redirect_to(open_case_path(:id=>@new.id), :notice=>'Case was successfully saved')
    else
      flash[:error] = "Could not save using the name provided"
      render :action=>'save_as'
    end
  end

  def create
    @case.user = current_user
    if @case.save
      @case.reload
      redirect_to(edit_case_situation_path(:case_id=>@case.id, :id=> @case.current_situation.id), :notice => 'Case was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @case.update_attributes(params[:case]) 
      redirect_to(:back)
    else
      render :action => "edit"
    end
  end

  def delete
    @case
  end

  def destroy
    @case.destroy
    redirect_to(cases_url)
  end
  
  def open
    if @case.has_unfinished_situation?
      situation = @case.situation_in_progress
      redirect_to edit_case_situation_path(:case_id=>@case.id, :id=>situation.id)
    else
      redirect_to numeric_results_path(:case_id=>@case.id)
    end
  end

  def share
    @cases = @current_user.cases(:order=> 'updated_at desc').where(:type=>nil)
    @users = User.where('id<>? AND receive_fileshare=?', @current_user.id,true)
  end

  def commit_share
    users = User.where(:id=>params[:people]).where(:receive_fileshare=>true)
    cases = Case.where(:id=>params[:share])
    errors = []
    cases.each do |c|
      shared = c.share_with users
      if !shared.save
        errors << shared.errors
      else
        users.each do |u|
         # UserMailer.shared_file(u,shared) if u.receive_share_email
           UserMailer.shared_file(u,shared).deliver if u.receive_share_email
        end
      end
    end
    if errors.count == 0
      redirect_to cases_share_path, :notice=>'Shared successfully'
    else
      redirect_to cases_share_path, :error=> 'Something went wrong with your sharing'
    end
  end
  def notes
    respond_to do |format|
      format.pdf do
        pdf = CaseNotesPdf.new(@case, @groups, view_context)
        send_data pdf.render, filename: pdf.file_name, type: "application/pdf", disposition: "inline"
      end
    end
  end
  def all
    @groups = QuestionGroup.all
    @parents = QuestionGroup.nav_parent_groups
    flash[:error] = "Can't find case" unless @case
    respond_to do |format|
      format.js {render :layout=>nil, :content_type => 'text/html' }
      format.html
      format.pdf do
        pdf = InputQuestionsAnswersPdf.new(@case, @groups, view_context)
        send_data pdf.render, filename: pdf.file_name, type: "application/pdf", disposition: "inline"
      end
    end
  end
  def print
    respond_to do |format|
      format.js {render :layout=>nil, :content_type => 'text/html' }
      format.html
    end
  end
end

