module FreebaseImporters
  class Car < Base
    def self.mql
      {
        "name" => nil,
        "/common/topic/image" => [ { "id" => nil } ],
        "model_years" => [ { "name" => nil } ],
        "make" => [{"name" => nil }],
        "type" => "/automotive/model"
      }
    end

    map :name
    map_images
    map :model_years, -> { data["model_years"].collect {|my| my["name"] } }
    map :make,        -> { data["make"].collect {|make| make["name"] }.first }

  end
end