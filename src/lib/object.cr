module Git
  class Object
    getter repo : Repo
    getter safe : Safe::Object::Type

    def initialize(@repo, @safe)
    end

    def type
      C.object_type safe
    end

    def commit?
      type == C::ObjCommit
    end

    def tree?
      type == C::ObjTree
    end

    def blob?
      type == C::ObjBlob
    end

    def tag?
      type == C::ObjTag
    end

    def id
      Oid.new(Safe::Oid.value(C.object_id(@safe).value))
    end
  end
end
