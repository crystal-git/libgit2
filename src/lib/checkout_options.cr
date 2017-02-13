module Git
  class CheckoutOptions
    getter safe : Safe::CheckoutOptions::Value

    def initialize(@safe)
    end

    def initialize
      initialize Safe::CheckoutOptions.init
    end

    def dup
      CheckoutOptions.new(@safe.dup)
    end

    def value
      @safe.value
    end

    def p
      @safe.p
    end
  end
end
