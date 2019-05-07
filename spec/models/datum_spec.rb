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

  describe "Validations" do
    before :each do
      @datum = FactoryBot.build(:datum)
    end
    
    it "should correctly save valid datum" do
      expect(@datum.save).to be_truthy
      expect(@datum.persisted?).to be_truthy
    end

    describe "skin_type" do
      it "should be present" do
        @datum.skin_type = nil
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:skin_type)
      end

      it "should be included in a valid set" do
        @datum.skin_type = ""
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:skin_type)
        @datum.skin_type = "toto"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:skin_type)
        @datum.skin_type = "124"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:skin_type)
        @datum.skin_type = "pale"
        @datum.save
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:skin_type)
      end
    end

    describe "prefered_color" do
      it "should be present" do
        @datum.prefered_color = nil
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_color)
      end

      it "should be included in a valid set" do
        @datum.prefered_color = ""
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_color)
        @datum.prefered_color = "toto"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_color)
        @datum.prefered_color = "124"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_color)
        @datum.prefered_color = "red"
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:prefered_color)
      end
    end

    describe "prefered_scent" do
      it "should be present" do
        @datum.prefered_scent = nil
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_scent)
      end

      it "should be included in a valid set" do
        @datum.prefered_scent = ""
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_scent)
        @datum.prefered_scent = "toto"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_scent)
        @datum.prefered_scent = "124"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_scent)
        @datum.prefered_scent = "lila"
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:prefered_scent)
      end
    end

    describe "age_group" do
      it "should be present" do
        @datum.age_group = nil
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:age_group)
      end

      it "should be included in a valid set" do
        @datum.age_group = ""
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:age_group)
        @datum.age_group = "toto"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:age_group)
        @datum.age_group = "124"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:age_group)
        @datum.age_group = "46_60"
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:age_group)
      end
    end

    describe "prefered_brand" do
      it "should be present" do
        @datum.prefered_brand = nil
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_brand)
      end

      it "should be included in a valid set" do
        @datum.prefered_brand = ""
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_brand)
        @datum.prefered_brand = "toto"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_brand)
        @datum.prefered_brand = "124"
        expect(@datum.save).to be_falsy
        expect(@datum.errors).to include(:prefered_brand)
        @datum.prefered_brand = "Monoprix"
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:prefered_brand)
      end
    end
  end
end
