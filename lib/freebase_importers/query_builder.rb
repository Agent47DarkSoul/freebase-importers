module FreebaseImporters
  class QueryBuilder
    def initialize
      @filters, @maps = [], []
    end

    # add a filter or whatever
    # "type" => "/book/book",
    def map(target, value = nil, comparison = nil, &block)
      if !value || value.empty? || block_given?
        # create accesor
      end
    end
  end
end