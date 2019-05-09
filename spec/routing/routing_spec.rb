require 'rails_helper'

RSpec.describe VivatechMatchbot, type: :routing do
  describe "API" do
    describe "v1" do
      it "should route to data#create" do
        expect(post: "/api/v1/data.json").to route_to(
          controller: "api/v1/data",
          action: "create",
          format: "json"
        )
      end

      it "should route to data#index" do
        expect(get: "/api/v1/data.json").to route_to(
          controller: "api/v1/data",
          action: "index",
          format: "json"
        )
      end
    end
  end

  describe "Results" do
    describe "Index" do
      it "should route to results#index" do
        expect(get: "/").to route_to(
          controller: "results",
          action: "index"
        )
      end
    end
  end
end