require "spec_helper"

describe ChartResultsController do
  describe "routing" do

    it "routes to #index" do
      get("/chart_results").should route_to("chart_results#index")
    end

    it "routes to #new" do
      get("/chart_results/new").should route_to("chart_results#new")
    end

    it "routes to #show" do
      get("/chart_results/1").should route_to("chart_results#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chart_results/1/edit").should route_to("chart_results#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chart_results").should route_to("chart_results#create")
    end

    it "routes to #update" do
      put("/chart_results/1").should route_to("chart_results#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chart_results/1").should route_to("chart_results#destroy", :id => "1")
    end

  end
end
