require 'spec_helper'

describe WebTipsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/web_tips" }.should route_to(:controller => "web_tips", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/web_tips/new" }.should route_to(:controller => "web_tips", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/web_tips/1" }.should route_to(:controller => "web_tips", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/web_tips/1/edit" }.should route_to(:controller => "web_tips", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/web_tips" }.should route_to(:controller => "web_tips", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/web_tips/1" }.should route_to(:controller => "web_tips", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/web_tips/1" }.should route_to(:controller => "web_tips", :action => "destroy", :id => "1") 
    end
  end
end
