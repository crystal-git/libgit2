module Git
  class Commit
    getter repo : Repo
    @safe : Safe::Commit

    def initialize(@repo, @safe)
    end

    @message : String?
    def message
      @message ||= Safe.string(:commit_message_raw, @safe)
    end
  end
end
