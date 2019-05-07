require 'rails_helper'

RSpec.describe Datum, type: :model do
  describe "Attributes" do
    it "should have a skin_type" do
      expect(Datum.new).to respond_to(:skin_type)
      expect(Datum.new.attributes.keys).to include("skin_type")
    end

    it "should have a prefered_color" do
      expect(Datum.new).to respond_to(:prefered_color)
      expect(Datum.new.attributes.keys).to include("prefered_color")
    end

    it "should have a prefered_scent" do
      expect(Datum.new).to respond_to(:prefered_scent)
      expect(Datum.new.attributes.keys).to include("prefered_scent")
    end

    it "should have a age_group" do
      expect(Datum.new).to respond_to(:age_group)
      expect(Datum.new.attributes.keys).to include("age_group")
    end

    it "should have a prefered_brand" do
      expect(Datum.new).to respond_to(:prefered_brand)
      expect(Datum.new.attributes.keys).to include("prefered_brand")
    end
  end
end
