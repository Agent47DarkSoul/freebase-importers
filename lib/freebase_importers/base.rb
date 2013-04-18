module FreebaseImporters
  class Base
    attr_reader :data
    def initialize(data)
      @data = data
    end
    def mapped
      self.class.mapped.inject({}) {|sum, i| sum[i] = send(i) ; sum }
    end

    private
    def self.base_url
      Addressable::URI.parse('https://www.googleapis.com/freebase/v1/mqlread')
    end

    def self.query(mql, cursor = nil)
      url = base_url
      url.query_values = {
        'query' => [mql].to_json,
        'cursor' => cursor
      }
      RestClient.get url.normalize.to_s, format: :json
    end

    def self.json_query(mql, cursor=nil)
      JSON.parse(query(mql, cursor))
    end

    def self.all(limit = 10)
      more_pages = true
      while(limit > 0 && more_pages) do
        cursor ||= nil
        json_response = json_query(mql, cursor)
        result = json_response['result']
        cursor = more_pages = json_response['cursor']
        result.collect {|r| new(r) }.each do |model|
          yield(model)
        end
      end
    end

    def self.mapped
      @mapped ||= []
    end

    def self.map(map_to, mql_key = nil)
      mql_key ||= map_to
      proc = case mql_key
      when String, Symbol
        -> { data[mql_key.to_s] }
      when Proc
        mql_key
      end
      mapped << map_to
      define_method map_to, proc
    end

    def self.map_images
      map :thumbnail,   -> { thumbnails.first }
      map :thumbnails,  -> { data['/common/topic/image'].collect {|image| freebase_thumb_url(image['id']) } }
      map :image,       -> { images.first }
      map :images,      -> { data['/common/topic/image'].collect {|image| freebase_image_url(image['id']) } }
    end

    def freebase_thumb_url(path)
      "https://usercontent.googleapis.com/freebase/v1/image#{path}"
    end

    def freebase_image_url(path)
      "https://api.freebase.com/api/trans/raw#{path}"
    end
  end
end