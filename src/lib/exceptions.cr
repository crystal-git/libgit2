module Git
  class Exception < ::Exception
  end

  class NotExactLocation < Exception
    def initialize(expected, actual)
      super "Git location not exact: #{expected} is expected, but #{actual}"
    end
  end

  class MergeConflict < Exception
    def initialize
      super "Git merge conflict."
    end
  end

  class InvalidUrl < Exception
    def initialize(s)
      super "Invalid Git URL: #{s}"
    end
  end
end
