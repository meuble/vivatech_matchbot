require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  render_views
  
  describe "#index" do
    it "should render home template" do
      get :index
      expect(response).to render_template(:index)
    end
    
    it "should render status 200" do
      get :index
      expect(response).to have_http_status(:success)
    end

  end
end
