module Git::Util
  struct Memo(T)
    property! value : T?
    @memo = false

    def initialize(@value = nil)
    end

    def memo
      unless @memo
        @memo = true
        @value = yield @value
      end
      @value
    end
  end
end
