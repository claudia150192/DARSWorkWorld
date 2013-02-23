require 'spec_helper'

describe WebNumericalResultsGroupsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/web_numerical_results_groups" }.should route_to(:controller => "web_numerical_results_groups", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/web_numerical_results_groups/new" }.should route_to(:controller => "web_numerical_results_groups", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/web_numerical_results_groups/1" }.should route_to(:controller => "web_numerical_results_groups", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/web_numerical_results_groups/1/edit" }.should route_to(:controller => "web_numerical_results_groups", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/web_numerical_results_groups" }.should route_to(:controller => "web_numerical_results_groups", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/web_numerical_results_groups/1" }.should route_to(:controller => "web_numerical_results_groups", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/web_numerical_results_groups/1" }.should route_to(:controller => "web_numerical_results_groups", :action => "destroy", :id => "1") 
    end
  end
end
