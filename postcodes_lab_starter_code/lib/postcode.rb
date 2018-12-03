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

  def get_element search_field , number_of_postcodes
    if number_of_postcodes == 1
      @single_postcode['result'][search_field]
    elsif number_of_postcodes > 1
      generate_array search_field
    end
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

  def get_query position
    @multiple_postcodes['result'][position]['query'].gsub(" ","")
  end
end
