module Git::Safe
  module Strarray
    include Safe

    define_safe :strarray, value: true

    def each
      (0..(value.count-1)).each do |i|
        yield String.new(value.strings[i])
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
