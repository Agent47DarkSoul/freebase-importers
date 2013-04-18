module FreebaseImporters
  class Book < Base
    def self.mql
      [{
        "name" => nil,
        "characters" => [],
        "genre" => [],
        "type" => "/book/book"
      }]
    end

    map :name
    map :genre,      -> { genres.first }
    map :genres,     -> { data["genre"] }
    map :characters, -> { data["characters"] }

  end
end