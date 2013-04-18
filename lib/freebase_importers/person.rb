module FreebaseImporters
  class Person < Base
    def self.mql
      {
        "id" => nil,
        "name" => nil,
        "place_of_birth" => nil,
        "/common/topic/image" => [{
          "id" => nil
        }],
        "type" => "/people/person"
      }
    end

    map :name
    map :place_of_birth
    map :image,   -> { freebase_image (data['/common/topic/image'].first || {})['id'] }
    map :images,  -> { data['/common/topic/image'].collect {|image| freebase_image(image['id']) } }

  end
end