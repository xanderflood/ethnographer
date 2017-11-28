require "rails_helper"

RSpec.describe CulturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cultures").to route_to("cultures#index")
    end

    it "routes to #new" do
      expect(:get => "/cultures/new").to route_to("cultures#new")
    end

    it "routes to #show" do
      expect(:get => "/cultures/1").to route_to("cultures#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cultures/1/edit").to route_to("cultures#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cultures").to route_to("cultures#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cultures/1").to route_to("cultures#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cultures/1").to route_to("cultures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cultures/1").to route_to("cultures#destroy", :id => "1")
    end

  end
end
