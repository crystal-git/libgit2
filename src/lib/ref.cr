module Git
  class Ref
    getter repo : Repo
    getter safe : Safe::Reference::Type

    def initialize(@repo, @safe)
    end

    @name : String?
    def name
      @name ||= Safe.string(:reference_name, @safe)
    end

    def remote?
      C.reference_is_remote(@safe) == 1
    end

    def branch?
      C.reference_is_branch(@safe) == 1
    end

    def tag?
      C.reference_is_tag(@safe) == 1
    end

    def note?
      C.reference_is_note(@safe) == 1
    end

    def peel
      Safe.call :reference_peel, out obj, @safe, C::OBJ_ANY do |call|
        if call.success?
          Safe::Object.safe(obj)
        elsif call.result == C::Enotfound
          nil
        else
          call.raise!
        end
      end
    end

    def set_head
      repo.set_head name
    end

    def to_oid?
      repo.ref_to_oid?(name)
    end

    def to_oid
      repo.ref_to_oid(name)
    end

    def to_commit?
      if oid = to_oid?
        repo.lookup_commit?(oid)
      end
    end

    def to_commit
      repo.lookup_commit(to_oid)
    end

    def to_annotated_commit
      repo.get_annotated_commit(self)
    end

    def delete
      Safe.call :reference_delete, @safe
    end
  end
end

require "./ref/*"
