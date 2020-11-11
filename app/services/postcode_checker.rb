# frozen_string_literal: true

require 'net/http'
require 'json'

# retrieve a postcode
class PostcodeChecker
  def check(postcode)
    url = URI.parse('http://postcodes.io/postcodes/')

    req = Net::HTTP::Get.new('http://postcodes.io/postcodes/' + postcode)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }

    # p res.body

    case res
    when Net::HTTPSuccess
      body = JSON.parse(res.body)

      if body['result']['lsoa'].start_with?('Lambeth', 'Southwark')
        res.body
      else
        'postcode ignored'
      end

    when Net::HTTPNotFound
      hash = JSON.parse(res.body)
      if hash['error'] == 'Postcode not found'
        postcode
      elsif hash['error'] == 'Invalid postcode'
        'Invalid postcode'
      end
    else
      'not servable'
    end
  end
end
