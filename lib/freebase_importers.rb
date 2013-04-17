require 'dotenv'
Dotenv.load

require "freebase/importers/version"

require "addressable/uri"
require "rest_client"
require "json"

# https://developers.google.com/freebase/v1/mql-overview

module FreebaseImporters
  def self.api_key
    ENV['GOOGLE_SIMPLE_API_ACCESS'] || missing_api_key_error!
  end

  def self.missing_api_key_error!
    puts
    puts "Create a GOOGLE_SIMPLE_API_ACCESS environment vairable (maybe use gem dotenv)."
    puts "Follow these instructions to get a Freebase api key: http://wiki.freebase.com/wiki/How_to_obtain_an_API_key"
    puts
    raise "No api key."
  end

  module Cars
    def self.search

      url = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/search')
      url.query_values = {
        'query' => 'Cee Lo Green',
        'filter' => '(all type:/music/artist created:"The Lady Killer")',
        'limit' => 10,
        'indent' => true,
        'key' => FreebaseImporters.api_key
      }
      response = RestClient.get url.normalize.to_str, format: :json
      puts JSON.parse(response)
    end

    def self.mql_search
      url = Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')
      url.query_values = {
        'query' =>
          [{
            "name" => nil,
            "/common/topic/image" => [{}],
            "type" => "/automotive/model"
          }].to_json
      }
      response = RestClient.get url.normalize.to_str, format: :json
      JSON.parse(response)
    end
  end
end

# puts FreebaseImporters::Cars.mql_search