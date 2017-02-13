module Git
  class Diff
    getter safe : Safe::Diff::Type

    def initialize(@safe)
    end

    def empty?
      C.diff_num_deltas(@safe) == 0
    end
  end
end
