module Git
  class AnnotatedCommit
    getter repo : Repo
    getter safe : Safe::AnnotatedCommit::Type

    def initialize(@repo, @safe)
    end
  end
end
