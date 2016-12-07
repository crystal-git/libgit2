module Git
  class Refspec
    getter remote : Remote
    getter string : String

    def initialize(@remote, @string)
    end
  end
end
