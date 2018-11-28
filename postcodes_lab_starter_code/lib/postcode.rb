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

  def get_status method_selector
    if method_selector == 'single'
      @single_postcode['status']
    elsif method_selector == 'multiple'
      @multiple_postcodes['status']
    end
  end

  def get_type method_selector
    if method_selector == 'single'
      @single_postcode.class
    elsif method_selector == 'multiple'
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

  def get_postcode method_selector
    if method_selector == 'single'
      postcode = @single_postcode["result"]["postcode"]
      postcode.gsub(" ","")
    elsif method_selector == 'multiple'
      condensed_string_array = []
      (generate_array 'postcode').each do |postcode|
        condensed_postcode = postcode.gsub(" ","")
        condensed_string_array << condensed_postcode
      end
      condensed_string_array
    end
  end

  def get_quality_key method_selector, position
    if method_selector == 'single'
      @single_postcode["result"]["quality"]
    elsif method_selector == 'multiple'
      @multiple_postcodes['result'][position]['result']['quality']
    end
  end

  def get_ordnance_survey_eastings method_selector
    if method_selector == 'single'
      @single_postcode['result']['eastings']
    elsif method_selector == 'multiple'
      generate_array 'eastings'
    end
  end

  def get_ordnance_survey_northings method_selector
    if method_selector == 'single'
      @single_postcode['result']['northings']
    elsif method_selector == 'multiple'
      generate_array 'northings'
    end
  end

  def get_country method_selector
    if method_selector == 'single'
      @single_postcode['result']['country']
    elsif method_selector == 'multiple'
      generate_array 'country'
    end
  end

  def get_NHS method_selector
    if method_selector == 'single'
      @single_postcode['result']['nhs_ha']
    elsif method_selector == 'multiple'
      generate_array 'nhs_ha'
    end
  end

  def get_longitude method_selector
    if method_selector == 'single'
      @single_postcode['result']['longitude']
    elsif method_selector == 'multiple'
      generate_array 'longitude'
    end
  end

  def get_latitude method_selector
    if method_selector == 'single'
      @single_postcode['result']['latitude']
    elsif method_selector == 'multiple'
      generate_array 'latitude'
    end
  end

  def get_parliamentary_constituency method_selector
    if method_selector == 'single'
      @single_postcode['result']['parliamentary_constituency']
    elsif method_selector == 'multiple'
      generate_array 'parliamentary_constituency'
    end
  end

  def get_european_electoral_region method_selector
    if method_selector == 'single'
      @single_postcode['result']['european_electoral_region']
    elsif method_selector == 'multiple'
      generate_array 'european_electoral_region'
    end
  end

  def get_primary_care_trust method_selector
    if method_selector == 'single'
      @single_postcode['result']['primary_care_trust']
    elsif method_selector == 'multiple'
      generate_array 'primary_care_trust'
    end
  end

  def get_region method_selector
    if method_selector == 'single'
      @single_postcode['result']['region']
    elsif method_selector == 'multiple'
      generate_array 'region'
    end
  end

  def get_parish method_selector
    if method_selector == 'single'
      @single_postcode['result']['parish']
    elsif method_selector == 'multiple'
      generate_array 'parish'
    end
  end

  def get_lsoa method_selector
    if method_selector == 'single'
      @single_postcode['result']['lsoa']
    elsif method_selector == 'multiple'
      generate_array 'lsoa'
    end
  end

  def get_msoa method_selector
    if method_selector == 'single'
      @single_postcode['result']['msoa']
    elsif method_selector == 'multiple'
      generate_array 'msoa'
    end
  end

  def get_admin_district method_selector
    if method_selector == 'single'
      @single_postcode['result']['admin_district']
    elsif method_selector == 'multiple'
      generate_array 'admin_district'
    end
  end

  def get_incode method_selector
    if method_selector == 'single'
      @single_postcode['result']['incode']
    elsif method_selector == 'multiple'
      generate_array 'incode'
    end
  end

  def get_outcode method_selector
    if method_selector == 'single'
      @single_postcode['result']['outcode']
    elsif method_selector == 'multiple'
      generate_array 'outcode'
    end
  end

  def get_query position
    @multiple_postcodes['result'][position]['query'].gsub(" ","")
  end
end
