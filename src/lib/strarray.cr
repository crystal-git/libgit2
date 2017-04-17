module Git
  class Strarray
    getter safe : Safe::Strarray::Type

    def initialize(@safe)
    end

    def each
      return if @safe.value.count < 1
      (0..(@safe.value.count-1)).each do |i|
        yield String.new(@safe.value.strings[i])
      end
    end

    def to_a
      a = %w()
      each do |s|
        a << s
      end
      a
    end
  end
end
