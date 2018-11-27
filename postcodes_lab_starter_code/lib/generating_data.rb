require 'faker'
require 'uk_postcode'

Faker::Config.locale = 'en-GB'

class RandomData
  include HTTParty

  base_uri'https://api.postcodes.io'

  def postcode_generator
    JSON.parse(self.class.get("/postcodes/#{postcode}").body)
  end
end
