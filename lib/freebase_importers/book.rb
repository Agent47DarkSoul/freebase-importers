module FreebaseImporters
  class Book < Base
    map :id
    map :name
    map :characters, []

    add_to_mql :"type", "/book/book"
    # # This limits books somewhat to works significant enough to have been translated.
    # add_to_mql :"ns0:type", "/book/translated_work"

    map :"/book/book/editions", []

    add_to_mql :"/book/written_work/author", []
    add_method :authors, CommonAccessors.single(:"/book/written_work/author")

    add_to_mql :genre, []
    add_method :genres,  -> { data['genre'] }
    add_method :genre,   -> { genres.first   }

    add_to_mql :"/book/written_work/date_of_first_publication"
    add_method :date_of_first_publication, -> {
      pub = data["/book/written_work/date_of_first_publication"]
      pub ? Date.parse(pub) : nil rescue pub
    }
    images!
  end
end