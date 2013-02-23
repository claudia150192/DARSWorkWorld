require 'spec_helper'

describe WebCalc do
  describe "#create" do
    before(:each) do
      @valid_attributes = {
        :name => "value for name",
        :operation => "1 + 2"
      }
      @invalid_attributes = {
        :name => "",
        :operation => "value for operation"
      }
    end

    it "should create a new instance given valid attributes" do
      WebCalc.create!(@valid_attributes)
    end
    
    it "should require name" do
      @web_calc = WebCalc.new(@invalid_attributes)
      @web_calc.should have(1).errors_on(:name)
    end
  end
  
  describe "#calculate" do
    before(:each) do
      @session = {}
      @session = { :situation => {:groups => { "test_group" => {} }}}
      @session[:situation][:groups]["test_group"] = { :questions => { 
        "BirthDate" => { :answer => "07/06/1986" }, 
        "SitDate" => { :answer => "12/08/2010" } 
      } }
      @manager ||= WWWebSessionManager.new(@session[:situation])
    end
    
    it "should calculate a proper result" do
      @web_calc = WebCalc.new(:name => "RAge")
      @web_calc.operation = "
        birthdate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
        sitdate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        answer = sitdate.year - birthdate.year
      "
      @web_calc.calculate(@manager).should == 24
    end
  end
end
