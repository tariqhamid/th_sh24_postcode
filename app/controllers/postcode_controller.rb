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

    @greeting = 'unknown'
    case res
    when Net::HTTPSuccess
      body = JSON.parse(res.body)
      # puts "#{body['result']['lsoa'].start_with?('Lambeth', 'Southwark')}"
      @greeting = body['result']['lsoa'] if body['result']['lsoa'].start_with?('Lambeth', 'Southwark')
    else
      # puts "*** #{request['postcode']}"
      @greeting = request['postcode']
      # res.value
    end

    # redirect_to index_url, greeting: "You have successfully logged out."
    # render html: helpers.tag.strong(@greeting)
  end
end
