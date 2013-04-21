require "addressable/uri"
require "rest_client"
require "json"

module FreebaseImporters
  class Query
    include Enumerable

    def initialize(mql, cursor = nil)
      @mql, @cursor = mql, cursor
    end

    def response
      @response ||= json_query
    end

    def result
      json_query['result']
    end

    # https://developers.google.com/freebase/v1/mql-overview#querying-with-cursor-paging-results
    def next
      if (new_cursor = response["cursor"])
        self.class.new(mql, new_cursor)
      end
    end

    def each(*args, &block)
      return enum_for(__callee__) unless block_given?
      result.each(*args, &block)
    end

    private
    attr_reader :mql, :cursor

    def base_url
      Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')
    end

    def query
      # puts "About to mql: #{mql.inspect}"
      url = base_url
      url.query_values = {
        'query' => [mql].to_json,
        'cursor' => cursor
      }
      RestClient.get url.normalize.to_s, format: :json
    end

    def json_query
      JSON.parse(query)
    end
  end
end