module Git
  class Repo
    class NoRevision < Git::Exception
      def initialize(repo, rev_spec)
        super "No revision: #{rev_spec} in #{repo.path}"
      end
    end

    @safe : Safe::Repository
    property! credential : Credentials::Base?

    private def initialize(@safe : Safe::Repository)
    end

    def initialize(path : String)
      Safe.call :repository_open, out unsafe, path
      initialize Safe::Repository.safe(unsafe)
    end

    def self.exists?(path : String)
      begin
        new(path)
        true
      rescue ex : Safe::CallError
        case ex.result
        when C::Enotfound
          false
        else
          raise ex
        end
      end
    end

    @path : String?
    def path
      @path ||= Safe.string(:repository_path, @safe)
    end

    @remotes : Hash(String, Remote)?
    def remotes
      @remotes ||= ({} of String => Remote).tap do |h|
        a = C::Strarray.new
        Safe.call :remote_list, pointerof(a), @safe
        Safe::Strarray.safe(a).each do |name|
          h[name] = lookup_remote(name).not_nil!
        end
      end
    end

    def lookup_remote(name)
      Safe.call :remote_lookup, out remote, @safe, name do |call|
        if call.success?
          Remote.new(self, Safe::Remote.safe(remote), name)
        elsif call.result == C::Enotfound
          nil
        else
          call.raise!
        end
      end
    end

    def parse_rev(spec)
      Safe.call :revparse_single, out obj, @safe, spec do |call|
        if call.success?
          Object.new(self, Safe::Object.safe(obj))
        elsif call.result == C::Enotfound
          nil
        else
          call.raise!
        end
      end
    end

    def lookup_ref(name)
      Safe.call :reference_dwim, out ref, @safe, name do |call|
        if call.success?
          Ref.new(self, Safe::Reference.safe(ref))
        elsif call.result == C::Enotfound
          nil
        else
          call.raise!
        end
      end
    end

    def head
      Safe.call :repository_head, out ref, @safe
      Ref.new(self, Safe::Reference.safe(ref))
    end

    def set_head(refname)
      Safe.call :repository_set_head, @safe, refname
    end

    def create_ref(name, oid)
      Safe.call :reference_create, out ref, @safe, name, oid.safe.p, 0, Util.null_pstr do |call|
        if call.success?
          Ref.new(self, Safe::Reference.safe(ref))
        elsif call.result == C::Eexists
          lookup_ref(name).not_nil!
        else
          call.raise!
        end
      end
    end

    def ref_name_to_oid(name)
      Safe.call :reference_name_to_id, out oid, @safe, name do |call|
        if call.success?
          Oid.new(self, Safe::Oid.safe(oid))
        elsif call.result == C::Enotfound
          nil
        else
          call.raise!
        end
      end
    end

    def checkout(name)
      if ref = lookup_ref(name)
        checkout ref
        return
      end
      checkout create_ref(name, head.to_oid)
    end

    def checkout(ref : Ref)
      ref.set_head
    end
  end
end
