class ChartResultsController < ApplicationController
  before_filter :require_user
  load_and_authorize_resource

  # GET /chart_results
  # GET /chart_results.xml
  def index
    @chart_results = ChartResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chart_results }
    end
  end

  # GET /chart_results/1
  # GET /chart_results/1.xml
  def show
    @chart_result = ChartResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chart_result }
    end
  end

  # GET /chart_results/new
  # GET /chart_results/new.xml
  def new
    @chart_result = ChartResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chart_result }
    end
  end

  # GET /chart_results/1/edit
  def edit
    @chart_result = ChartResult.find(params[:id])
  end

  # POST /chart_results
  # POST /chart_results.xml
  def create
    @chart_result = ChartResult.new(params[:chart_result])

    respond_to do |format|
      if @chart_result.save
        format.html { redirect_to(@chart_result, :notice => 'Chart result was successfully created.') }
        format.xml  { render :xml => @chart_result, :status => :created, :location => @chart_result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chart_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chart_results/1
  # PUT /chart_results/1.xml
  def update
    @chart_result = ChartResult.find(params[:id])

    respond_to do |format|
      if @chart_result.update_attributes(params[:chart_result])
        format.html { redirect_to(@chart_result, :notice => 'Chart result was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chart_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chart_results/1
  # DELETE /chart_results/1.xml
  def destroy
    @chart_result = ChartResult.find(params[:id])
    @chart_result.destroy

    respond_to do |format|
      format.html { redirect_to(chart_results_url) }
      format.xml  { head :ok }
    end
  end
end
