require 'rails_helper'

RSpec.describe Api::V1::DataController, type: :controller do
  describe "#create" do
    it "should render json" do
      post :create, format: :json
      expect(response.header['Content-Type']).to include('application/json')
    end

    describe "with no authentication" do
      before :each do
        @data_attributes = {
          skin_type: Faker::Lorem.word,
          prefered_color: Faker::Color.color_name.to_s,
          prefered_brand: Faker::Lorem.word,
          age_group: Faker::Lorem.word,
          prefered_scent: Faker::Lorem.word,
          zipcode: Faker::Address.zip_code
        }
      end

      it "should not create a data entry" do
        expect do
          post :create, params: @data_attributes, format: :json
        end.not_to change(Datum, :count)
      end

      it "should return unauthorised http status" do
        post :create, format: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
    
    describe "with authentication" do
      before :each do
        allow(controller).to receive(:require_token).and_return(true)
      end

      describe "with valid parameters" do
        before :each do
          @data_attributes = {
            skin_type: Datum::SKIN_TYPES.shuffle.first,
            prefered_color: Datum::COLORS.shuffle.first,
            prefered_brand: Datum::BRANDS.shuffle.first,
            age_group: Datum::AGE_GROUPS.shuffle.first,
            prefered_scent: Faker::Lorem.word,
            zipcode: Faker::Address.zip_code,
            gender: Datum::GENDERS.shuffle.first,
            auth_token: "authorized_token"
          }
        end
      
        it "should create a new data" do
          expect do
            post :create, params: @data_attributes, format: :json
          end.to change(Datum, :count).by(1)
        end

        it "should create the new data with correct data" do
          post :create, params: @data_attributes, format: :json
          expect(assigns(:datum).skin_type).to eq(@data_attributes[:skin_type])
          expect(assigns(:datum).prefered_color).to eq(@data_attributes[:prefered_color])
          expect(assigns(:datum).prefered_brand).to eq(@data_attributes[:prefered_brand])
          expect(assigns(:datum).age_group).to eq(@data_attributes[:age_group])
          expect(assigns(:datum).prefered_scent).to eq(@data_attributes[:prefered_scent])
          expect(assigns(:datum).department).to eq(@data_attributes[:zipcode].to_s[0..1])
          expect(assigns(:datum).gender).to eq(@data_attributes[:gender])
        end
      
        it "should render newly created data" do
          post :create, params: @data_attributes, format: :json
          new_data = JSON.parse(response.body)
          expect(new_data["skin_type"]).to eq(@data_attributes[:skin_type])
          expect(new_data["prefered_color"]).to eq(@data_attributes[:prefered_color])
          expect(new_data["prefered_brand"]).to eq(@data_attributes[:prefered_brand])
          expect(new_data["age_group"]).to eq(@data_attributes[:age_group])
          expect(new_data["prefered_scent"]).to eq(@data_attributes[:prefered_scent])
          expect(new_data["department"]).to eq(@data_attributes[:zipcode].to_s[0..1])
          expect(new_data["gender"]).to eq(@data_attributes[:gender])
        end
      
        it "should render 201 status" do
          post :create, params: @data_attributes, format: :json
          expect(response).to have_http_status(201)
        end
        
        it "should create Datum with age instead of age_group" do
          data_attributes = {
            skin_type: Datum::SKIN_TYPES.shuffle.first,
            prefered_color: Datum::COLORS.shuffle.first,
            prefered_brand: Datum::BRANDS.shuffle.first,
            age: Faker::Number.between(15, 100),
            prefered_scent: Faker::Lorem.word,
            zipcode: Faker::Address.zip_code,
            auth_token: "authorized_token"
          }
          expect do
            post :create, params: data_attributes, format: :json
          end.to change(Datum, :count).by(1)
        end
      end
    
      describe "with invalid parameters" do
        it "should create no data" do
          expect do
            post :create, format: :json
          end.not_to change(Datum, :count)
        end
      
        it "should render error" do
          post :create, format: :json
          expect(JSON.parse(response.body)).to include("errors")
        end
      
        it "should render 400" do
          post :create, format: :json
          expect(response).to have_http_status(400)
        end
      end
    end
  end
  
  describe "#index" do
    it "should render json" do
      get :index, format: :json
      expect(response.header['Content-Type']).to include('application/json')
    end

    describe "with no authentication" do
      before :each do
        10.times { FactoryBot.create(:datum) }
      end

      it "should return dataCount key" do
        get :index, format: :json
        data = JSON.parse(response.body)
        expect(data["dataCount"]).to eq(Datum.count)
      end

      it "should return skinTypeResults key" do
        expect(Datum).to receive(:skin_type_results).and_return("valid_skin_type_results")
        get :index, format: :json
        data = JSON.parse(response.body)
        expect(data["skinTypeResults"]).to eq("valid_skin_type_results")
      end
    end

    describe "with authentication" do
      before :each do
        10.times { FactoryBot.create(:datum) }
        allow(controller).to receive(:require_token).and_return(true)
      end
      
      it "should return dataCount key" do
        get :index, format: :json
        data = JSON.parse(response.body)
        expect(data["dataCount"]).to eq(Datum.count)
      end

      it "should return skinTypeResults key" do
        expect(Datum).to receive(:skin_type_results).and_return("valid_skin_type_results")
        get :index, format: :json
        data = JSON.parse(response.body)
        expect(data["skinTypeResults"]).to eq("valid_skin_type_results")
      end
    end
  end
end
