module Git
  class Diff
    getter safe : Safe::Diff::Type

    def initialize(@safe)
    end

    def empty?
      delta_count == 0
    end

    def delta_count
      C.diff_num_deltas(@safe)
    end

    def each
      i = 0
      while i < delta_count
        yield delta_at(i)
        i += 1
      end
    end

    def delta_at(index : LibC::SizeT)
      Safe::DiffDelta.pointer(Safe.call(:diff_get_delta, @safe, index))
    end
  end
end
