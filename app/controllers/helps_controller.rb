class HelpsController < ApplicationController
  layout "application"
  load_and_authorize_resource
  before_filter :require_user, :only => [:create, :new, :edit, :update, :destroy,:confirm] 
  
  def index
    @topics = Help.all
  end

  def edit
    @topic = Help.find_by_id(params[:id])
  end

  def update
    @topic = Help.find_by_id(params[:id])
    if @topic.update_attributes(params[:help])
      flash[:notice] = "Help topic has been updated"
      redirect_to(help_path(@topic))
    else
      render :action=> :edit
    end
  end

  def create
    @topic = Help.new(params[:help])
    if @topic.save
      flash[:notice] = "Help topic has been created"
      redirect_to(help_path(@topic))
    else
      render :action=>:new
    end
  end

  def new
    @topic = Help.new
  end

  def show
    if params[:topic]
      @document=Help.find_by_topic(params[:topic])
    else
      @document=Help.find_by_id(params[:id])
    end
    respond_to do |format|
      format.js {render :layout=>nil, :content_type => 'text/html' }
      format.html { @document }
    end
  end

  def destroy
    topic = Help.find_by_id(params[:id])
    topic.destroy
  end
end
