# frozen_string_literal: true

require 'net/http'
require 'json'

# retrieve a postcode
class PostcodeController < ApplicationController
  def new; end

  def index
    url = URI.parse('http://postcodes.io/postcodes/')

    req = Net::HTTP::Get.new('http://postcodes.io/postcodes/' + request[:postcode])
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }

    p res.body

    case res
    when Net::HTTPSuccess
      body = JSON.parse(res.body)
      # puts "#{body['result']['lsoa'].start_with?('Lambeth', 'Southwark')}"
      @greeting =
        if body['result']['lsoa'].start_with?('Lambeth', 'Southwark')
          res.body
        else
          'postcode ignored'
        end

    when Net::HTTPNotFound
      hash = JSON.parse(res.body)
      @greeting =
        if hash['error'] == 'Postcode not found'
          request[:postcode]
        elsif hash['error'] == 'Invalid postcode'
          'Invalid postcode'
        end
    else
      @greeting = 'not servable'
    end

    # redirect_to index_url, greeting: "You have successfully logged out."
    # render html: helpers.tag.strong(@greeting)
  end
end
