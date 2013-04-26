module FreebaseImporters
  class Animal < Base
    map :id
    map :name

    map :"/biology/organism_classification/higher_classification"
    map :"/biology/organism_classification/lower_classifications", []
    map :"/fictional_universe/character_species/characters_of_this_species", []

    add_to_mql :"type", "/biology/animal"
    add_to_mql :"/biology/organism_classification/rank", "species"
    images!
  end
end
# module FreebaseImporters
#   class President < Base
#     map :name
#     map :id
#
#     add_to_mql :"/government/us_president/presidency_number", []
#     add_method :presidency_numbers, -> { data["/government/us_president/presidency_number"] }
#
#     map :"/people/person/date_of_birth"
#     add_method :date_of_birth, -> {
#       date = data["/people/person/date_of_birth"]
#       date ? Date.parse(date) : nil rescue date
#     }
#
#     map :"/people/person/height_meters"
#
#     add_to_mql :type, "/government/us_president"
#     images!
#   end
# end
