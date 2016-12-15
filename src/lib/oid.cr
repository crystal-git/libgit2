module Git
  class Oid
    getter repo : Repo
    getter safe : Safe::Oid

    def initialize(@repo, @safe)
    end

    def to_object
      repo.lookup_object self
    end
  end
end
