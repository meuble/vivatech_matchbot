require 'rails_helper'

class DummyAuthenticableController < ActionController::Base
  include Authenticable
end

describe DummyAuthenticableController, type: :controller do
  describe "#require_token" do
    describe "with valid token" do
      it "should return true" do
        subject.params[:token] = Rails.application.credentials.dig(:api, :token)
        expect { subject.require_token}.not_to raise_error
      end
    end

    describe "without token" do
      it "should raise missing token error" do
        expect do
          subject.require_token
        end.to raise_error(Authenticable::BadToken)
      end
    end

    describe "with malformed token" do
      it "should raise Authenticable::BadToken error" do
        subject.params[:token] = ""
        expect do
          subject.require_token
        end.to raise_error(Authenticable::BadToken)
        
        subject.params[:token] = nil
        expect do
          subject.require_token
        end.to raise_error(Authenticable::BadToken)
      end
    end
  end

  describe "#token" do
    it "should find the token in params (token)" do
      subject.params[:token] = "1234"
      expect(subject.token).to eq("1234")
    end
    
    it "should find the token in params (auth_token)" do
      subject.params[:auth_token] = "1234"
      expect(subject.token).to eq("1234")
    end
    
    it "should find the token in authorisation header" do
      subject.request = double()
      allow(subject.request).to receive(:headers).and_return({"Authorization" => "Bearer 1234"})
      expect(subject.token).to eq("1234")
    end

    it "should find the token in an HTTPOnly cookie" do
      stub_cookie_jar = double()
      allow(stub_cookie_jar).to receive(:signed).and_return(HashWithIndifferentAccess.new)
      stub_cookie_jar.signed[:token] = "1234"
      allow(subject).to receive(:cookies).and_return(stub_cookie_jar)
      
      expect(subject.token).to eq("1234")
    end
  end
  
  describe "#token_from_request_headers" do
    it "should return content of authorisation header if present" do
      subject.request = double()
      allow(subject.request).to receive(:headers).and_return({"Authorization" => "Bearer 1234"})
      expect(subject.token_from_request_headers).to eq("1234")
    end
    
    it "should return nil with no authorisation header" do
      expect(subject.token_from_request_headers).to be_nil
    end
  end

  describe "in action" do    
    describe "enforcing authentication" do
      controller(DummyAuthenticableController) do
        before_action :require_token
        
        def index
          head :ok
        end
      end
      
      before :each do
      end

      it "should responds with 401 if token not provided" do
        get :index
        assert_response :unauthorized
      end

      it "should responds with 200 if token provided" do
        get :index, params: {auth_token: Rails.application.credentials.dig(:api, :token)}
        assert_response :success
      end
    end
  end
end