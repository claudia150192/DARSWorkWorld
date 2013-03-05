class UsersController < ApplicationController
  layout "application"
  load_and_authorize_resource
  before_filter :require_user, :only => [:show, :edit, :update, :destroy,:confirm]
  
  def index
    @users = User.all
    authorize! :manage, @user
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      UserMailer.activation_instructions(@user).deliver
      if (@current_user)
        flash[:notice] = "Please have the user check email for activation instructions!"
      else
        flash[:notice] = "Account created.  Please check your email for activation instructions!"
      end
      
      @user.activate! #TODO: Remove this once email confirmations are working
      
      redirect_to :registration_confirmation
    else
      render :action => :new
    end
  end

  def registration_confirmation
    if(@current_user)
      @message = "Please have the user check email for activation instructions!"
    else
      @message = "Account created. Please check your email for activation instructions!"
    end
  end

  def activate
    @user = User.find_by_id(params[:id])
    authorize! :activate, @user
    @user.activate!
    flash[:notice] = @user.login + " was successfully activated"
    redirect_to edit_user_path(@user)
  end

  def show
    @user ||= @current_user
  end

  def edit
    @user ||= @current_user
  end

  def update
    @user ||= @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      if can?(:assign_roles, @user)
        @user.admin = params[:user][:admin]
        @user.save
      end
      flash[:notice] = "Account updated!"
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end

  def confirm
    @user = User.find_by_id params[:id]
    flash[:notice] =  "You are about to delete the user '#{@user.login}', do you wish to continue?"
  end

  def destroy
    user = User.find_by_id params[:id]
    user.destroy
    flash[:notice] = "User deleted!"
    redirect_to(users_url)
  end
end
