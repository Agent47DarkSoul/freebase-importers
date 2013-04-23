module FreebaseImporters
  class Base
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def self.map(target, value = nil)
      add_to_mql(target, value)
      target_ending = target.to_s.split('/').last
      add_method(target_ending, CommonAccessors.single(target))
    end

    def self.add_to_mql(key, value = nil)
      mql[key.to_s] = value
    end

    def self.add_method(name, proc)
      define_method(name, proc)
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

    def self.endless(pause = 1)
      q = query
      while q do
        q.each do |result|
          yield new(result)
        end
        puts "Getting some more in #{pause} seconds." unless pause == 0
        sleep pause
        q = q.next
      end
    end

    def self.first
      all {|m| break(m) }
    end

    def self.images!
      key = "/common/topic/image"
      add_to_mql key, [ { "id" => nil } ]
      add_method :image_ids, CommonAccessors.deep(key, :id)
      add_method :image_urls,     -> { image_ids.collect {|id| freebase_image_url(id) } }
      add_method :thumbnail_urls, -> { image_ids.collect {|id| freebase_thumb_url(id) } }

      add_method :image_url,     -> { image_urls.first }
      add_method :thumbnail_url, -> { thumbnail_urls.first }

    end

    class << self
      private

      def mql
        @mql ||= {}
      end
    end

    def freebase_thumb_url(path)
      "https://usercontent.googleapis.com/freebase/v1/image#{path}"
    end

    def freebase_image_url(path)
      "https://api.freebase.com/api/trans/raw#{path}"
    end
  end
end
