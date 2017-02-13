module Git
  class DiffOptions
    getter safe : Safe::DiffOptions::Value

    def initialize(@safe)
    end

    def initialize
      initialize Safe::DiffOptions.init
    end

    def dup
      DiffOptions.new(@safe.dup)
    end

    def value
      @safe.value
    end

    def p
      @safe.p
    end
  end
end
