require "spec_helper"

describe ChartsController do
  describe "routing" do

    it "routes to #index" do
      get("/charts").should route_to("charts#index")
    end

    it "routes to #new" do
      get("/charts/new").should route_to("charts#new")
    end

    it "routes to #show" do
      get("/charts/1").should route_to("charts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/charts/1/edit").should route_to("charts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/charts").should route_to("charts#create")
    end

    it "routes to #update" do
      put("/charts/1").should route_to("charts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/charts/1").should route_to("charts#destroy", :id => "1")
    end

  end
end
