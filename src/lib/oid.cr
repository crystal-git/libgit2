module Git
  class Oid
    getter repo : Repo
    getter safe : Safe::Oid

    def initialize(@repo, @safe)
    end
  end
end
