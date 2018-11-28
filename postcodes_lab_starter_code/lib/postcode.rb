require 'httparty'
require 'json'

class Postcodesio
  include HTTParty

  attr_accessor :single_postcode , :multiple_postcodes, :array

  base_uri 'https://api.postcodes.io'

  def initialize
    @single_postcode = 0
    @multiple_postcodes = 0
    @array = []
  end

  def get_single_postcode
    @single_postcode = JSON.parse(self.class.get("/random/postcodes").body)
  end

  def get_multiple_postcodes
    postcodes_array = []
    for i in 0...3 do
      randomly_generated_location_information = JSON.parse(self.class.get("/random/postcodes").body)
      extracted_postcode = randomly_generated_location_information['result']['postcode']
      postcodes_array << extracted_postcode
    end
    @multiple_postcodes = JSON.parse(self.class.post('/postcodes', body: { "postcodes" => postcodes_array}).body)
    @multiple_postcodes
  end

  def get_status number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['status']
    elsif number_of_postcodes > 1
      @multiple_postcodes['status']
    end
  end

  def get_type number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode.class
    elsif number_of_postcodes > 1
      @multiple_postcodes.class
    end
  end

  def generate_array key_word
    @array = []
    for i in 0...3 do
      @array << @multiple_postcodes['result'][i]['result'][key_word]
    end
    array
  end

  def get_postcode number_of_postcodes
    if number_of_postcodes == 1
      postcode = @single_postcode["result"]["postcode"]
      postcode.gsub(" ","")
    elsif number_of_postcodes > 1
      condensed_string_array = []
      (generate_array 'postcode').each do |postcode|
        condensed_postcode = postcode.gsub(" ","")
        condensed_string_array << condensed_postcode
      end
      condensed_string_array
    end
  end

  def get_quality_key number_of_postcodes, position
    if number_of_postcodes == 1
      @single_postcode["result"]["quality"]
    elsif number_of_postcodes > 1
      @multiple_postcodes['result'][position]['result']['quality']
    end
  end

  def get_ordnance_survey_eastings number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['eastings']
    elsif number_of_postcodes > 1
      generate_array 'eastings'
    end
  end

  def get_ordnance_survey_northings number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['northings']
    elsif number_of_postcodes > 1
      generate_array 'northings'
    end
  end

  def get_country number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['country']
    elsif number_of_postcodes > 1
      generate_array 'country'
    end
  end

  def get_NHS number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['nhs_ha']
    elsif number_of_postcodes > 1
      generate_array 'nhs_ha'
    end
  end

  def get_longitude number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['longitude']
    elsif number_of_postcodes > 1
      generate_array 'longitude'
    end
  end

  def get_latitude number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['latitude']
    elsif number_of_postcodes > 1
      generate_array 'latitude'
    end
  end

  def get_parliamentary_constituency number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['parliamentary_constituency']
    elsif number_of_postcodes > 1
      generate_array 'parliamentary_constituency'
    end
  end

  def get_european_electoral_region number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['european_electoral_region']
    elsif number_of_postcodes > 1
      generate_array 'european_electoral_region'
    end
  end

  def get_primary_care_trust number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['primary_care_trust']
    elsif number_of_postcodes > 1
      generate_array 'primary_care_trust'
    end
  end

  def get_region number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['region']
    elsif number_of_postcodes > 1
      generate_array 'region'
    end
  end

  def get_parish number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['parish']
    elsif number_of_postcodes > 1
      generate_array 'parish'
    end
  end

  def get_lsoa number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['lsoa']
    elsif number_of_postcodes > 1
      generate_array 'lsoa'
    end
  end

  def get_msoa number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['msoa']
    elsif number_of_postcodes > 1
      generate_array 'msoa'
    end
  end

  def get_admin_district number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['admin_district']
    elsif number_of_postcodes > 1
      generate_array 'admin_district'
    end
  end

  def get_incode number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['incode']
    elsif number_of_postcodes > 1
      generate_array 'incode'
    end
  end

  def get_outcode number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result']['outcode']
    elsif number_of_postcodes > 1
      generate_array 'outcode'
    end
  end

  def get_query position
    @multiple_postcodes['result'][position]['query'].gsub(" ","")
  end
end
