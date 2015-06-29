require 'httparty'

class PhillyOpenDataClient
  include HTTParty
  base_uri 'data.phila.gov/resource'	
  format :json
  debug_output $stdout
  
  # Resources
  # PhillyOpenDataClient::RESOURCE_NAME
  PARKING_VIOLATIONS = '/2pfz-fnns.json'
  
  # Response Keys
  FIELD_NAMES = 'x-soda2-fields'
  
  attr_reader :resource
  
  def initialize(resource_path)
    resource = resource_path
  end
  
  def all_records(order = 'issue_date_and_time')
	@options = {}
	
    self.class.get(PARKING_VIOLATIONS, query: @options )
  end
  
  def page_records(limit = 10, offset = 0, order = 'issue_date_and_time')
	@options = {}
	
	@options[:$limit] = limit
	@options[:$offset] = offset
	@options[:$order] = "#{order} DESC	"
	
    self.class.get(PARKING_VIOLATIONS, query: @options )
  end
  
  def by_column(column_name, column_value, limit = 10, offset = 0, order = 'issue_date_and_time')
	@options = {}
	
	@options[column_name] = "#{column_value}"
	@options[:$limit] = limit
	@options[:$offset] = offset
	@options[:$order] = "#{order} DESC	"
	
    self.class.get(PARKING_VIOLATIONS, query: @options )
  end
  
  private
  
	attr_writer :resource
end