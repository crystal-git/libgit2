module Git
  class FetchOptions
    getter safe : Safe::FetchOptions::Value

    def initialize(@safe)
    end

    def initialize
      initialize Safe::FetchOptions.init
    end

    def dup
      FetchOptions.new(@safe.dup)
    end

    def value
      @safe.value
    end

    def p
      @safe.p
    end
  end
end
