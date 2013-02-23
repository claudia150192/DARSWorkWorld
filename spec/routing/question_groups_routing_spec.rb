require 'spec_helper'

describe QuestionGroupsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/question_groups" }.should route_to(:controller => "question_groups", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/question_groups/new" }.should route_to(:controller => "question_groups", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/question_groups/1" }.should route_to(:controller => "question_groups", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/question_groups/1/edit" }.should route_to(:controller => "question_groups", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/question_groups" }.should route_to(:controller => "question_groups", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/question_groups/1" }.should route_to(:controller => "question_groups", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/question_groups/1" }.should route_to(:controller => "question_groups", :action => "destroy", :id => "1") 
    end
  end
end
