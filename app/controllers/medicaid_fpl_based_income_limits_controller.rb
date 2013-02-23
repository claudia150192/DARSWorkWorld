class MedicaidFplBasedIncomeLimitsController < ApplicationController
  layout 'application'
  load_and_authorize_resource
  
  # GET /medicaid_fpl_based_income_limits
  # GET /medicaid_fpl_based_income_limits.xml
  def index
    @medicaid_fpl_based_income_limits = MedicaidFplBasedIncomeLimit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @medicaid_fpl_based_income_limits }
    end
  end

  # GET /medicaid_fpl_based_income_limits/1
  # GET /medicaid_fpl_based_income_limits/1.xml
  def show
    @medicaid_fpl_based_income_limit = MedicaidFplBasedIncomeLimit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @medicaid_fpl_based_income_limit }
    end
  end

  # GET /medicaid_fpl_based_income_limits/new
  # GET /medicaid_fpl_based_income_limits/new.xml
  def new
    @medicaid_fpl_based_income_limit = MedicaidFplBasedIncomeLimit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @medicaid_fpl_based_income_limit }
    end
  end

  # GET /medicaid_fpl_based_income_limits/1/edit
  def edit
    @medicaid_fpl_based_income_limit = MedicaidFplBasedIncomeLimit.find(params[:id])
  end

  # POST /medicaid_fpl_based_income_limits
  # POST /medicaid_fpl_based_income_limits.xml
  def create
    @medicaid_fpl_based_income_limit = MedicaidFplBasedIncomeLimit.new(params[:medicaid_fpl_based_income_limit])

    respond_to do |format|
      if @medicaid_fpl_based_income_limit.save
        format.html { redirect_to(@medicaid_fpl_based_income_limit, :notice => 'Medicaid fpl based income limit was successfully created.') }
        format.xml  { render :xml => @medicaid_fpl_based_income_limit, :status => :created, :location => @medicaid_fpl_based_income_limit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @medicaid_fpl_based_income_limit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /medicaid_fpl_based_income_limits/1
  # PUT /medicaid_fpl_based_income_limits/1.xml
  def update
    @medicaid_fpl_based_income_limit = MedicaidFplBasedIncomeLimit.find(params[:id])

    respond_to do |format|
      if @medicaid_fpl_based_income_limit.update_attributes(params[:medicaid_fpl_based_income_limit])
        format.html { redirect_to(@medicaid_fpl_based_income_limit, :notice => 'Medicaid fpl based income limit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @medicaid_fpl_based_income_limit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /medicaid_fpl_based_income_limits/1
  # DELETE /medicaid_fpl_based_income_limits/1.xml
  def destroy
    @medicaid_fpl_based_income_limit = MedicaidFplBasedIncomeLimit.find(params[:id])
    @medicaid_fpl_based_income_limit.destroy

    respond_to do |format|
      format.html { redirect_to(medicaid_fpl_based_income_limits_url) }
      format.xml  { head :ok }
    end
  end
end
