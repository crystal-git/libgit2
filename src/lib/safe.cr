module Git
  class Safe(T)
    getter unsafe : T
    getter? const : Bool

    def initialize(@unsafe : T, @const)
    end

    def p
      pointerof(@unsafe)
    end

    def self.const(unsafe)
      new(unsafe, true)
    end

    def self.non_const(unsafe)
      new(unsafe, false)
    end
  end
end

require "./safe/macros"
require "./safe/*"
