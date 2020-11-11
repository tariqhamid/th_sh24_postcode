# frozen_string_literal: true

require 'test_helper'

class PostcodeFlowsTest < ActionDispatch::IntegrationTest
  test 'start page' do
    get '/'
    assert_select 'label', 'Please enter a postcode:'
  end

  test 'response' do
    get index_path(postcode: "SE1 7QA")
    assert_equal 200, response.status
  end
end
