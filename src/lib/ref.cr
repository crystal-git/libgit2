module Git
  class Ref
    getter repo : Repo
    @safe : Safe::Reference

    def initialize(@repo, @safe)
    end

    def remote?
      C.reference_is_remote(@safe) == 1
    end

    def name
      Safe.string(:reference_name, @safe)
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
      repo.ref_name_to_oid(name)
    end

    def to_oid
      to_oid?.not_nil!
    end
  end
end
