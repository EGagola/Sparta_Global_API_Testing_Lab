require 'httparty'

class RandomData
  include HTTParty

  attr_accessor :single_postcode

  base_uri'https://api.postcodes.io'


end
