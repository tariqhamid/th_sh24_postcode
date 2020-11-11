# frozen_string_literal: true

require 'test_helper'

class PostcodeCheckerTest < ActionDispatch::IntegrationTest
  test 'postcode checker SE1 7QA' do
    response = PostcodeChecker.new.check('SE1 7QA')
    assert response.start_with?('{"status":200')
  end

  test 'postcode checker xxx' do
    response = PostcodeChecker.new.check('xxx')
    assert response == 'Invalid postcode'
  end

  test 'postcode checker SH24 1AA' do
    response = PostcodeChecker.new.check('SH24 1AA')
    assert response == 'SH24 1AA'
  end
end