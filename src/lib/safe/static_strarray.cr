module Git::Safe
  class StaticStrarray
    include Enumerable(String)
    include Indexable(String)

    @array = %w()

    def initialize(a : Enumerable(String))
      a.each do |i|
        @array << i
      end
    end

    def each
      @array.each do |i|
        yield i
      end
    end

    def unsafe_at(index : Int)
      @array.unsafe_at(index)
    end

    @pointers = [] of (LibC::Char*)
    @unsafe = uninitialized C::Strarray

    def to_unsafe
      @pointers.clear
      each do |e|
        @pointers << e.to_unsafe
      end
      @unsafe.strings = size > 0 ? @pointers.to_unsafe : Util.null_ppstr
      @unsafe.count = size
      pointerof(@unsafe)
    end
  end
end
