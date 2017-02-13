module Git
  class Signature
    getter safe : Safe::Signature::Type

    def initialize(@safe)
    end
  end
end
