module Git
  class Rebase
    getter repo : Repo
    getter safe : Safe::Rebase::Type

    def initialize(@repo, @safe)
    end

    def next
      Safe.call :rebase_next, out operation, @safe do |call|
        if call.success?
          true
        elsif call.result == C::Iterover
          false
        else
          call.raise!
        end
      end
    end

    def inmemory_index
      Safe.call :rebase_inmemory_index, out index, @safe
      Index.new(Safe::Index.heap(index))
    end

    def commit(signature : Signature)
      Safe.call :rebase_commit, out oid, @safe, nil, signature.safe.p, nil, nil
      Oid.new(Safe::Oid.value(oid))
    end

    def abort
      Safe.call :rebase_abort, @safe
    end

    def finish(signature : Signature)
      Safe.call :rebase_finish, @safe, signature.safe.p
    end
  end
end
