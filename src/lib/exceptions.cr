module Git
  class Exception < ::Exception
  end

  class NotExactLocation < Exception
    def initialize(expected, actual)
      super "Git location not exact: #{expected} is expected, but #{actual}"
    end
  end
end
