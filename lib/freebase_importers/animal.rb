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
