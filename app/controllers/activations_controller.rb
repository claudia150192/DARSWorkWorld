class ActivationsController < ApplicationController
    before_filter :require_no_user

    def create
      @user = User.find_using_perishable_token(params[:token], 1.week) || (raise Exception)
      raise Exception if @user.active?

      if @user.activate!
        flash[:notice] = "Your account has been activated!"
        UserMailer.welcome_email(@user).deliver
        
        redirect_to cases_path
      else
        render :action => :new
      end
    end

end
