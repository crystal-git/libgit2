module Git
  class Tree
    getter safe : Safe::Tree::Type

    def initialize(@safe)
    end
  end
end
