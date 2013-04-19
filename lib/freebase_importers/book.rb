module FreebaseImporters
  class Book < Base
    def self.mql
      {
        "name" => nil,
        "characters" => [],
        "genre" => [],
        "/book/written_work/date_of_first_publication" => nil,
        "type" => "/book/book",
        "/book/written_work/author" => []
      }
    end

    map :name
    map :genre,        -> { genres.first }
    map :genres,       -> { data["genre"] }
    map :characters,   -> { data["characters"] }
    map :authors,      -> { data["/book/written_work/author"] }
    map :publish_date, -> {
      pub = data["/book/written_work/date_of_first_publication"]
      pub ? Date.parse(pub) : nil rescue pub
    }

  end
end