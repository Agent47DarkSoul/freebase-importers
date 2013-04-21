# Freebase::Importers

Some help for getting Freebase data into a more flat form.

## Installation

    gem 'freebase-importers'
    require 'freebase_importers'

## Usage

Figure out your query via https://www.freebase.com/query

Then define a model to make that query and load accessors with results.

    class Book < FreebaseImporters::Base
      map :name
      map :characters, []

      add_to_mql :"type", "/book/book"

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
    end

*map* is good when you want to modify mql to get a value from Freebase and also create an accessor with the same name.

*add_to_mq* just modifies mql.

*add_method* just adds a method.

After defining a model, you query it like:

    # "all" is a bit of a misnomer, actually just
    # makes one query for a default of 100 records
    Book.all do |book|
      puts "#{book.name}, #{book.date_of_first_publication}"
    end

    # endless is not a misnomer ...
    # records will keep coming until Google quits sending them
    # The argument indicates the duration to pause between requests.
    Book.endless(7) do |book|
      puts "#{book.name}, #{book.date_of_first_publication}"
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
