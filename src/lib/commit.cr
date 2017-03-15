module Git
  class Commit
    getter repo : Repo
    getter safe : Safe::Commit::Type

    def initialize(@repo, @safe)
    end

    @message : String?
    def message
      @message ||= Safe.string(:commit_message_raw, @safe)
    end

    def to_tree
      Safe.call :commit_tree, out tree, @safe
      Tree.new(Safe::Tree.free(tree))
    end
  end
end
