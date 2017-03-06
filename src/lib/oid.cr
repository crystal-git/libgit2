module Git
  class Oid
    include Comparable(Oid)

    getter safe : Safe::Oid::Type

    def initialize(@safe)
    end

    def <=>(other : Oid)
      C.oid_cmp @safe.p, other.safe.p
    end

    @string : String?
    def string
      @string ||= begin
        p = C.oid_tostr_s(@safe.p)
        String.new(p)
      end
    end

    def self.from(s : String)
      Safe.call :oid_fromstrp, out oid, s
      Oid.new(Safe::Oid.value(oid))
    end
  end
end
