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

    def self.query
      Query.new(mql)
    end

    def self.all
      query.each do |result|
        yield new(result)
      end
    end

    class << self
      private
      def builder
        @builder ||= QueryBuilder.new
      end

      def mql
        @mql ||= {}
      end
    end

    # add a filter or whatever
    # "name" => nil,
    # "/common/topic/image" => [ { "id" => nil } ],
    # "model_years" => [ { "name" => nil } ],
    # "make" => [{"name" => nil }],
    # "type" => "/automotive/model"
    def self.map2(target, value = nil, options = {}, &block)
      mql["#{target}#{options[:comparison]}"] = value
      key = "#{target}".split('/').last
      if !value || value.empty? || block_given?
        if block_given?
          define_method key, block
        else
          define_method key, -> { data[target.to_s] }
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