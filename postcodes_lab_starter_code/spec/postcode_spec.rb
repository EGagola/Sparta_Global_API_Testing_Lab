require 'spec_helper'



describe Postcodesio do

  context 'requesting information on a single postcode works correctly' do

    before(:all) do
      @random_data = RandomData.new
      @postcodesio = Postcodesio.new
      @postcodesio.get_single_postcode('TW106NF')
      @response = @postcodesio
    end

    it "should respond with a status message of 200" do
      expect(@response.get_status('single').to_i).to eq 200
    end

    it "should have a results hash" do
      expect(@response.get_type('single')).to eq Hash
    end

    it "should return a postcode between 5-7 in length"  do
      expect(@response.get_postcode('single').length).to be_between(5,7).inclusive
    end

    it "should return an quality key integer between 1-9" do
      expect(@response.get_quality_key('single',0).to_i).to be_between(1,9).inclusive
    end

    it "should return an ordnance survey eastings value as integer" do
      expect(@response.get_ordnance_survey_eastings('single').class).to eq(Integer)
    end

    it "should return an ordnance survey northings value as integer" do
      expect(@response.get_ordnance_survey_northings('single').class).to eq(Integer)
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      expect(@response.get_country('single')).to eq("England").or eq("Scotland").or eq("Northern Ireland").or eq("Wales")
    end

    it "should return a string value for NHS authority " do
      expect(@response.get_NHS('single').class).to eq String
    end

    it "should return a longitude float value" do
      expect(@response.get_longitude('single').class).to eq Float
    end

    it "should return a latitude float value" do
      expect(@response.get_latitude('single').class).to eq Float
    end

    it "should return a parliamentary constituency string" do
      expect(@response.get_parliamentary_constituency('single').class).to eq String
    end

    it "should return a european_electoral_region string" do
      expect(@response.get_european_electoral_region('single').class).to eq String
    end

    it "should return a primary_care_trust string" do
      expect(@response.get_primary_care_trust('single').class).to eq String
    end

    it "should return a region string" do
      expect(@response.get_region('single').class).to eq String
    end

    it "should return a parish string" do
      expect(@response.get_parish('single').class).to eq String
    end

    it "should return a lsoa string" do
      expect(@response.get_lsoa('single').class).to eq String
    end

    it "should return a msoa string" do
      expect(@response.get_msoa('single').class).to eq String
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      expect(@response.get_admin_district('single').class).to eq String
    end

    it "should return a incode string of three characters" do
      expect(@response.get_incode('single').length).to eq 3
    end

    it "should return a outcode string of 3-4 characters" do
      expect(@response.get_outcode('single').length).to be_between(3,4).inclusive
    end
  end

  context "multiple postcodes validation" do

    before(:all) do
      data_array = ['HP52BN','TW106NF','S101BJ']
      @postcodesio = Postcodesio.new
      @postcodesio.get_multiple_postcodes(data_array)
      @response = @postcodesio
    end

    it "should respond with a status message of 200" do
      expect(@response.get_status('multiple').to_i).to eq 200
    end

    it "should return the first query as the first postcode in the response" do
      expect(@response.get_first_query).to eq "HP52BN"
    end

    it "should return the second query as the second postcode in the response" do
      expect(@response.get_second_query).to eq "TW106NF"
    end

    it "should have a results hash" do
      expect(@response.get_type('multiple')).to eq Hash
    end

    it "should return a postcode between 5-7 in length"  do
      expect(@response.get_postcode('multiple').length).to be_between(15,21).inclusive
    end

    it "should return an quality key integer between 1-9" do
      for i in 0...3 do
        expect(@response.get_quality_key('multiple',i)).to be_between(1,9).inclusive
      end
    end

    it "should return an ordnance survey eastings value as integer" do
      @response.get_ordnance_survey_eastings('multiple').each do |easting|
        expect(easting).to be_kind_of Integer
      end
    end

    it "should return an ordnance survey northings value as integer" do
      @response.get_ordnance_survey_northings('multiple').each do |northing|
        expect(northing).to be_kind_of Integer
      end
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      @response.get_country('multiple').each do |easting|
        expect(easting).to eq('England').or eq('Scotland').or eq('Northern Ireland').or eq('Wales')
      end
    end

    it "should return a string value for NHS authority " do
      @response.get_NHS('multiple').each do |nhs|
        expect(nhs).to be_kind_of String
      end
    end

    it "should return a longitude float value" do
      @response.get_longitude('multiple').each do |longitude|
        expect(longitude).to be_kind_of Float
      end
    end

    it "should return a latitude float value" do
      @response.get_latitude('multiple').each do |latitude|
        expect(latitude).to be_kind_of Float
      end
    end

    it "should return a parliamentary constituency string" do
      @response.get_parliamentary_constituency('multiple').each do |parliamentary_constituency|
        expect(parliamentary_constituency).to be_kind_of String
      end
    end

    it "should return a european_electoral_region string" do
      @response.get_european_electoral_region('multiple').each do |european_electoral_region|
        expect(european_electoral_region).to be_kind_of String
      end
    end

    it "should return a primary_care_trust string" do
      @response.get_primary_care_trust('multiple').each do |primary_care_trust|
        expect(primary_care_trust).to be_kind_of String
      end
    end

    it "should return a region string" do
      @response.get_region('multiple').each do |region|
        expect(region).to be_kind_of String
      end
    end

    it "should return a parish string" do
      @response.get_parish('multiple').each do |parish|
        expect(parish).to be_kind_of String
      end
    end

    it "should return a lsoa string" do
      @response.get_lsoa('multiple').each do |lsoa|
        expect(lsoa).to be_kind_of String
      end
    end

    it "should return a msoa string" do
      @response.get_msoa('multiple').each do |msoa|
        expect(msoa).to be_kind_of String
      end
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      @response.get_admin_district('multiple').each do |admin_district|
        expect(admin_district).to be_kind_of String
      end
    end

    it "should return a incode string of three characters" do
      @response.get_incode('multiple').each do |incode|
        expect(incode.length).to eq 3
      end
    end


    it "should return a outcode string of 3-4 characters" do
      @response.get_outcode('multiple').each do |outcode|
        expect(outcode.length).to be_between(3,4).inclusive
      end
    end
  end
end
