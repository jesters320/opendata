class HomeController < ApplicationController
  def index
	violations = PhillyOpenDataClient.new(PhillyOpenDataClient::PARKING_VIOLATIONS)
	
	response = violations.page_records
	
	logger.debug '*********response**********'
	logger.debug response
	
	logger.debug 'fields constant'
	logger.debug PhillyOpenDataClient::FIELD_NAMES
	
	@fields = JSON.parse response.headers[PhillyOpenDataClient::FIELD_NAMES]
	
	logger.debug '@fields'
	logger.debug @fields.to_json
	
	@top_ten = response.parsed_response
  
  end
end
