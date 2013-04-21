module FreebaseImporters
  class Book < Base
    map :name
    map :characters, []

    add_to_mql :"type", "/book/book"

    add_to_mql :"/book/written_work/author", []
    add_method :authors, CommonAccessors.single(:"/book/written_work/author")

    add_to_mql :genre, []
    add_method :genres,  -> { data['genre'] }
    add_method :genre,   -> { genre.first   }

    add_to_mql :"/book/written_work/date_of_first_publication"
    add_method :date_of_first_publication, -> {
      pub = data["/book/written_work/date_of_first_publication"]
      pub ? Date.parse(pub) : nil rescue pub
    }
  end
end