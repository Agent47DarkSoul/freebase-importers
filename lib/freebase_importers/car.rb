module FreebaseImporters
  class Car < Base
    def self.mql
      [{
        "name" => nil,
        "/common/topic/image" => [ { "id" => nil } ],
        "model_years" => [ { "name" => nil } ],
        "make" => [{"name" => nil }],
        "type" => "/automotive/model"
      }]
    end

    map :name
    map :thumbnail,   -> { freebase_image (data['/common/topic/image'].first || {})['id'] }
    map :thumbnails,  -> { data['/common/topic/image'].collect {|image| freebase_image(image['id']) } }
    map :model_years, -> { data["model_years"].collect {|my| my["name"] } }
    map :make,        -> { data["make"].collect {|make| make["name"] }.first }

  end
end