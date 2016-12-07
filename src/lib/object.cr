module Git
  class Object
    getter repo : Repo
    getter safe : Safe::Object

    def initialize(@repo, @safe)
    end

    def type
      C.object_type safe
    end
  end
end
