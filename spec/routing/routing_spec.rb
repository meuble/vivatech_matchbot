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
    end
  end
end