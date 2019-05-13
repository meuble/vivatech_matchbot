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

    it "should have a zipcode" do
      expect(Datum.new).to respond_to(:zipcode)
      expect(Datum.new.attributes.keys).to include("zipcode")
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
        @datum.skin_type = Datum::SKIN_TYPES.shuffle.first
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
        @datum.prefered_color = Datum::COLORS.shuffle.first
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:prefered_color)
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
        @datum.age_group = Datum::AGE_GROUPS.shuffle.first
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:age_group)
      end
    end

    describe "prefered_brand" do
      it "should be mandatory" do
        @datum.prefered_brand = nil
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:prefered_brand)
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
        @datum.prefered_brand = Datum::BRANDS.shuffle.first
        expect(@datum.save).to be_truthy
        expect(@datum.errors).not_to include(:prefered_brand)
      end
    end
  end
  
  describe "#age=" do
    it "should add error if bad param" do
      datum = Datum.new
      datum.age = "toto"
      expect(datum.errors).to include(:age_group)
    end
    
    it "should add error if age < 15" do
      datum = Datum.new
      datum.age = "toto"
      expect(datum.errors).to include(:age_group)
    end

    it "should set the age_group according to the age as string" do
      datum = Datum.new
      datum.age = "15"
      expect(datum.age_group).to eq("15-24")
      
      datum.age = "26"
      expect(datum.age_group).to eq("25-34")
      
      datum.age = "40"
      expect(datum.age_group).to eq("35-44")
      
      datum.age = "51"
      expect(datum.age_group).to eq("45-54")
      
      datum.age = "55"
      expect(datum.age_group).to eq("55+")
    end
    
    it "should set the age_group according to the age as integer" do
      datum = Datum.new
      datum.age = 15
      expect(datum.age_group).to eq("15-24")
      
      datum.age = 26
      expect(datum.age_group).to eq("25-34")
      
      datum.age = 40
      expect(datum.age_group).to eq("35-44")
      
      datum.age = 51
      expect(datum.age_group).to eq("45-54")
      
      datum.age = 55
      expect(datum.age_group).to eq("55+")
    end
  end
  
  describe ".skin_type_results" do
    before :each do
      FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[0], prefered_scent: Faker::Lorem.word,
        prefered_color: Datum::COLORS[0])
      FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[0], prefered_scent: Faker::Lorem.word,
        prefered_color: Datum::COLORS[0])
      FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[0], prefered_scent: Faker::Lorem.word,
        prefered_color: Datum::COLORS[1])
      FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[1])
      FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[2])
    end

    it "should return an array of skin_types" do
      expect(Datum.skin_type_results.count).to eq(3)
    end
    
    it "should call skin_type_result for each skin_type" do
      expect(Datum).to receive(:skin_type_result).at_least(3)
      expect(Datum.skin_type_results)
    end
  end
  
  describe ".skin_type_result" do
    before :each do
      @skin_type = Datum::SKIN_TYPES[0]
      s1, s2, s3, s4 =
        FactoryBot.create(:datum, skin_type: @skin_type),
        FactoryBot.create(:datum, skin_type: @skin_type),
        FactoryBot.create(:datum, skin_type: @skin_type),
        FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[1])
    end

    it "should return an hash" do
      expect(Datum.skin_type_result(@skin_type)).to be_a(Hash)
    end
    
    it "should return a title key" do
      result = Datum.skin_type_result(@skin_type)
      expect(result[:title]).to eq(Datum::SKIN_TYPES[0])
    end
    
    it "should return a scent key" do
      expect(Datum).to receive(:scent_results).with(@skin_type).and_return("scent_results")
      result = Datum.skin_type_result(@skin_type)
      expect(result[:scent]).to eq("scent_results")
    end
    
    it "should return a color key" do
      expect(Datum).to receive(:color_results).with(@skin_type).and_return("color_results")
      result = Datum.skin_type_result(@skin_type)
      expect(result[:colors]).to eq("color_results")
    end
    
    it "should return a brand key" do
      expect(Datum).to receive(:brand_results).with(@skin_type).and_return("brand_results")
      result = Datum.skin_type_result(@skin_type)
      expect(result[:brand]).to eq("brand_results")
    end

    it "should return a age_group key" do
      expect(Datum).to receive(:age_group_results).with(@skin_type).and_return("age_group_results")
      result = Datum.skin_type_result(@skin_type)
      expect(result[:age_group]).to eq("age_group_results")
    end
  end
  
  describe ".color_results" do
    before :each do
      @skin_type = Datum::SKIN_TYPES[0]
      s1, s2, s3, s4 =
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_color: Datum::COLORS[0]),
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_color: Datum::COLORS[0]),
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_color: Datum::COLORS[1]),
        FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[1])
    end

    it "should return all available colors" do
      colors = Datum.color_results(@skin_type)
      expect(colors.size).to eq(Datum::COLORS.size)
    end

    it "should return a correct count for declared colors" do
      colors = Datum.color_results(@skin_type)
      expect(colors).to include({color: Datum::COLORS[0], count: 2})
      expect(colors).to include({color: Datum::COLORS[1], count: 1})
    end
    
    it "should return 0 count for undeclared colors" do
      colors = Datum.color_results(@skin_type)
      expect(colors).to include({color: Datum::COLORS[2], count: 0})
    end
  end
  
  describe ".scent_results" do
    before :each do
      @skin_type = Datum::SKIN_TYPES[0]
      @last_scent = Faker::Lorem.word
      s1, s2, s3, s4 =
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_scent: Faker::Lorem.word),
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_scent: Faker::Lorem.word),
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_scent: @last_scent),
        FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[1])
    end

    it "should return most prefered scent" do
      result = Datum.skin_type_result(@skin_type)      
      expect(result[:scent]).to eq(@last_scent)
    end
  end

  describe ".brand_results" do
    before :each do
      @skin_type = Datum::SKIN_TYPES[0]
      s1, s2, s3, s4 =
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_brand: Datum::BRANDS[0]),
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_brand: Datum::BRANDS[1]),
        FactoryBot.create(:datum, skin_type: @skin_type, prefered_brand: Datum::BRANDS[0]),
        FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[1])
    end

    it "should return most prefered scent" do
      result = Datum.skin_type_result(@skin_type)
      expect(result[:brand]).to eq(Datum::BRANDS[0])
    end
  end

  describe ".age_group_results" do
    before :each do
      @skin_type = Datum::SKIN_TYPES[0]
      s1, s2, s3, s4 =
        FactoryBot.create(:datum, skin_type: @skin_type, age_group: Datum::AGE_GROUPS[0]),
        FactoryBot.create(:datum, skin_type: @skin_type, age_group: Datum::AGE_GROUPS[1]),
        FactoryBot.create(:datum, skin_type: @skin_type, age_group: Datum::AGE_GROUPS[0]),
        FactoryBot.create(:datum, skin_type: Datum::SKIN_TYPES[1])
    end

    it "should return most prefered scent" do
      result = Datum.skin_type_result(@skin_type)
      expect(result[:age_group]).to eq(Datum::AGE_GROUPS[0])
    end
  end
end
