require 'dotenv'
Dotenv.load

require "freebase_importers/version"

require "addressable/uri"
require "rest_client"
require "json"

# https://developers.google.com/freebase/v1/mql-overview
module FreebaseImporters

  Dir.glob("#{File.dirname(__FILE__)}/freebase_importers/*").each do |filename|
    class_name = File.basename(filename, '.*').split('_').collect(&:capitalize).join.to_sym
    autoload class_name, filename
  end

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

end

# puts FreebaseImporters::Cars.mql_search