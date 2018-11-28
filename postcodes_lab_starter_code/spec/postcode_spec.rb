require 'spec_helper'

describe Postcodesio do

  context 'requesting information on a single postcode works correctly' do

    before(:all) do

      @postcodesio = Postcodesio.new
      @postcodesio.get_single_postcode
      @response = @postcodesio
    end

    it "should respond with a status message of 200" do
      expect(@response.get_status(1).to_i).to eq 200
    end

    it "should have a results hash" do
      expect(@response.get_type(1)).to eq Hash
    end

    it "should return a postcode between 5-7 in length"  do
      expect(@response.get_postcode(1).length).to be_between(5,7).inclusive
    end

    it "should return an quality key integer between 1-9" do
      expect(@response.get_element('quality',1).to_i).to be_between(1,9).inclusive
    end

    it "should return an ordnance survey eastings value as integer" do
      expect(@response.get_element('eastings',1).class).to eq(Integer)
    end

    it "should return an ordnance survey northings value as integer" do
      expect(@response.get_element('northings',1).class).to eq(Integer)
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      expect(@response.get_element('country',1)).to eq("England").or eq("Scotland").or eq("Northern Ireland").or eq("Wales").or eq('Isle of Man')
    end

    it "should return a string value for NHS authority " do
      expect(@response.get_element('nhs_ha',1).class).to eq String
    end

    it "should return a longitude float value" do
      expect(@response.get_element('longitude',1).class).to eq Float
    end

    it "should return a latitude float value" do
      expect(@response.get_element('latitude',1).class).to eq Float
    end

    it "should return a parliamentary constituency string" do
      expect(@response.get_element('parliamentary_constituency',1).class).to eq String
    end

    it "should return a european_electoral_region string" do
      expect(@response.get_element('european_electoral_region',1).class).to eq String
    end

    it "should return a primary_care_trust string" do
      expect(@response.get_element('primary_care_trust',1).class).to eq String
    end

    it "should return a region string" do
      expect(@response.get_element('region',1).class).to eq(String).or eq(NilClass)
    end

    it "should return a parish string" do
      expect(@response.get_element('parish',1).class).to eq(String).or eq(NilClass)
    end

    it "should return a lsoa string" do
      expect(@response.get_element('lsoa',1).class).to eq String
    end

    it "should return a msoa string" do
      expect(@response.get_element('msoa',1).class).to eq(String).or eq(NilClass)
    end

    it "should return a admin_district string" do
      expect(@response.get_element('admin_district',1).class).to eq(String).or eq(NilClass)
    end

    it "should return a incode string of three characters" do
      expect(@response.get_element('incode',1).length).to eq 3
    end

    it "should return a outcode string of 2-4 characters" do
      expect(@response.get_element('outcode',1).length).to be_between(2,4).inclusive
    end
  end

  context "multiple postcodes validation" do

    before(:all) do
      @postcodesio = Postcodesio.new
      @postcodesio.get_multiple_postcodes
      @response = @postcodesio
    end

    it "should respond with a status message of 200" do
      expect(@response.get_status(3).to_i).to eq 200
    end

    it "should return the first query as the first postcode in the response" do
      expect(@response.get_query(0)).to eq(@response.get_postcode(3)[0])
    end

    it "should return the second query as the second postcode in the response" do
      expect(@response.get_query(1)).to eq(@response.get_postcode(3)[1])
    end

    it "should have a results hash" do
      expect(@response.get_type(3)).to eq Hash
    end

    it "should return a postcode between 5-7 in length"  do
      @response.get_postcode(3).each do |postcode|
        expect(postcode.length).to be_between(5,7).inclusive
      end
    end

    it "should return an quality key integer between 1-9" do
      @response.get_element('quality',3).each do |quality|
        expect(quality).to be_kind_of Integer
      end
    end

    it "should return an ordnance survey eastings value as integer" do
      @response.get_element('eastings',3).each do |easting|
        expect(easting).to be_kind_of Integer
      end
    end

    it "should return an ordnance survey northings value as integer" do
      @response.get_element('northings',3).each do |northing|
        expect(northing).to be_kind_of Integer
      end
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      @response.get_element('country',3).each do |country|
        expect(country).to eq('England').or eq('Scotland').or eq('Northern Ireland').or eq('Wales')
      end
    end

    it "should return a string value for NHS authority " do
      @response.get_element('nhs_ha',3).each do |nhs|
        expect(nhs).to be_kind_of String
      end
    end

    it "should return a longitude float value" do
      @response.get_element('longitude',3).each do |longitude|
        expect(longitude).to be_kind_of Float
      end
    end

    it "should return a latitude float value" do
      @response.get_element('latitude',3).each do |latitude|
        expect(latitude).to be_kind_of Float
      end
    end

    it "should return a parliamentary constituency string" do
      @response.get_element('parliamentary_constituency',3).each do |parliamentary_constituency|
        expect(parliamentary_constituency).to be_kind_of(String).or be_kind_of(NilClass)
      end
    end

    it "should return a european_electoral_region string" do
      @response.get_element('european_electoral_region',3).each do |european_electoral_region|
        expect(european_electoral_region).to be_kind_of(String).or be_kind_of(NilClass)
      end
    end

    it "should return a primary_care_trust string" do
      @response.get_element('primary_care_trust',3).each do |primary_care_trust|
        expect(primary_care_trust).to be_kind_of(String).or be_kind_of(NilClass)
      end
    end

    it "should return a region string" do
      @response.get_element('region',3).each do |region|
        expect(region).to be_kind_of(String).or be_kind_of(NilClass)
      end
    end

    it "should return a parish string" do
      @response.get_element('parish',3).each do |parish|
        expect(parish).to be_kind_of(String).or be_kind_of(NilClass)
      end
    end

    it "should return a lsoa string" do
      @response.get_element('lsoa',3).each do |lsoa|
        expect(lsoa).to be_kind_of String
      end
    end

    it "should return a msoa string" do
      @response.get_element('msoa',3).each do |msoa|
        expect(msoa).to be_kind_of(String).or be_kind_of(NilClass)
      end
    end

    it "should return a admin_district string" do
      @response.get_element('admin_district',3).each do |admin_district|
        expect(admin_district).to be_kind_of(String).or be_kind_of(NilClass)
      end
    end

    it "should return a incode string of three characters" do
      @response.get_element('incode',3).each do |incode|
        expect(incode.length).to eq 3
      end
    end


    it "should return a outcode string of 2-4 characters" do
      @response.get_element('outcode',3).each do |outcode|
        expect(outcode.length).to be_between(2,4).inclusive
      end
    end
  end
end
