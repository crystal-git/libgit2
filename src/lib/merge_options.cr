module Git
  class MergeOptions
    getter safe : Safe::MergeOptions::Value

    def initialize(@safe)
    end

    def initialize
      initialize Safe::MergeOptions.init
    end

    def dup
      MergeOptions.new(@safe.dup)
    end

    def value
      @safe.value
    end

    def p
      @safe.p
    end
  end
end
