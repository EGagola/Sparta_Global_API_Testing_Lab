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
      expect(@response.get_quality_key(1,0).to_i).to be_between(1,9).inclusive
    end

    it "should return an ordnance survey eastings value as integer" do
      expect(@response.get_ordnance_survey_eastings(1).class).to eq(Integer)
    end

    it "should return an ordnance survey northings value as integer" do
      expect(@response.get_ordnance_survey_northings(1).class).to eq(Integer)
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      expect(@response.get_country(1)).to eq("England").or eq("Scotland").or eq("Northern Ireland").or eq("Wales")
    end

    it "should return a string value for NHS authority " do
      expect(@response.get_NHS(1).class).to eq String
    end

    it "should return a longitude float value" do
      expect(@response.get_longitude(1).class).to eq Float
    end

    it "should return a latitude float value" do
      expect(@response.get_latitude(1).class).to eq Float
    end

    it "should return a parliamentary constituency string" do
      expect(@response.get_parliamentary_constituency(1).class).to eq String
    end

    it "should return a european_electoral_region string" do
      expect(@response.get_european_electoral_region(1).class).to eq String
    end

    it "should return a primary_care_trust string" do
      expect(@response.get_primary_care_trust(1).class).to eq String
    end

    it "should return a region string" do
      expect(@response.get_region(1).class).to eq String
    end

    it "should return a parish string" do
      expect(@response.get_parish(1).class).to eq String
    end

    it "should return a lsoa string" do
      expect(@response.get_lsoa(1).class).to eq String
    end

    it "should return a msoa string" do
      expect(@response.get_msoa(1).class).to eq String
    end

    it "should return a admin_district string" do
      expect(@response.get_admin_district(1).class).to eq String
    end

    it "should return a incode string of three characters" do
      expect(@response.get_incode(1).length).to eq 3
    end

    it "should return a outcode string of 2-4 characters" do
      expect(@response.get_outcode(1).length).to be_between(2,4).inclusive
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
      for i in 0...3 do
        expect(@response.get_quality_key(3,i)).to be_between(1,9).inclusive
      end
    end

    it "should return an ordnance survey eastings value as integer" do
      @response.get_ordnance_survey_eastings(3).each do |easting|
        expect(easting).to be_kind_of Integer
      end
    end

    it "should return an ordnance survey northings value as integer" do
      @response.get_ordnance_survey_northings(3).each do |northing|
        expect(northing).to be_kind_of Integer
      end
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      @response.get_country(3).each do |easting|
        expect(easting).to eq('England').or eq('Scotland').or eq('Northern Ireland').or eq('Wales')
      end
    end

    it "should return a string value for NHS authority " do
      @response.get_NHS(3).each do |nhs|
        expect(nhs).to be_kind_of String
      end
    end

    it "should return a longitude float value" do
      @response.get_longitude(3).each do |longitude|
        expect(longitude).to be_kind_of Float
      end
    end

    it "should return a latitude float value" do
      @response.get_latitude(3).each do |latitude|
        expect(latitude).to be_kind_of Float
      end
    end

    it "should return a parliamentary constituency string" do
      @response.get_parliamentary_constituency(3).each do |parliamentary_constituency|
        expect(parliamentary_constituency).to be_kind_of String
      end
    end

    it "should return a european_electoral_region string" do
      @response.get_european_electoral_region(3).each do |european_electoral_region|
        expect(european_electoral_region).to be_kind_of String
      end
    end

    it "should return a primary_care_trust string" do
      @response.get_primary_care_trust(3).each do |primary_care_trust|
        expect(primary_care_trust).to be_kind_of String
      end
    end

    it "should return a region string" do
      @response.get_region(3).each do |region|
        expect(region).to be_kind_of String
      end
    end

    it "should return a parish string" do
      @response.get_parish(3).each do |parish|
        expect(parish).to be_kind_of String
      end
    end

    it "should return a lsoa string" do
      @response.get_lsoa(3).each do |lsoa|
        expect(lsoa).to be_kind_of String
      end
    end

    it "should return a msoa string" do
      @response.get_msoa(3).each do |msoa|
        expect(msoa).to be_kind_of String
      end
    end

    it "should return a admin_district string" do
      @response.get_admin_district(3).each do |admin_district|
        expect(admin_district).to be_kind_of String
      end
    end

    it "should return a incode string of three characters" do
      @response.get_incode(3).each do |incode|
        expect(incode.length).to eq 3
      end
    end


    it "should return a outcode string of 2-4 characters" do
      @response.get_outcode(3).each do |outcode|
        expect(outcode.length).to be_between(2,4).inclusive
      end
    end
  end
end
