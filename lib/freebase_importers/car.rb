module FreebaseImporters
  class Car < Base
    map :name

    add_to_mql :type, "/automotive/model"

    add_to_mql :make, [{"name" => nil }]
    add_method :make, CommonAccessors.deep_singular(:make, :name)

    add_to_mql :model_years,  [ { "name" => nil } ]
    add_method :model_years, CommonAccessors.deep(:model_years, :name)

    images!

  end
end