module Git
  class PushOptions
    getter safe : Safe::PushOptions::Value

    def initialize(@safe)
    end

    def initialize
      initialize Safe::PushOptions.init
    end

    def dup
      PushOptions.new(@safe.dup)
    end

    def value
      @safe.value
    end

    def p
      @safe.p
    end
  end
end
