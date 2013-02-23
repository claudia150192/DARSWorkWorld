require 'spec_helper'

describe WebCalcsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/web_calcs" }.should route_to(:controller => "web_calcs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/web_calcs/new" }.should route_to(:controller => "web_calcs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/web_calcs/1" }.should route_to(:controller => "web_calcs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/web_calcs/1/edit" }.should route_to(:controller => "web_calcs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/web_calcs" }.should route_to(:controller => "web_calcs", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/web_calcs/1" }.should route_to(:controller => "web_calcs", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/web_calcs/1" }.should route_to(:controller => "web_calcs", :action => "destroy", :id => "1") 
    end
  end
end
