module Git
  class RebaseOptions
    getter safe : Safe::RebaseOptions::Value

    def initialize(@safe)
    end

    def initialize
      initialize Safe::RebaseOptions.init
    end

    def dup
      RebaseOptions.new(@safe.dup)
    end

    def value
      @safe.value
    end

    def p
      @safe.p
    end
  end
end
