# frozen_string_literal: true

require 'postcode_checker'

# retrieve a postcode
class PostcodeController < ApplicationController
  def new; end

  def index
    @greeting = PostcodeChecker.new.check(request[:postcode])
  end
end
