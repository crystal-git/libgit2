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

    def self.open?(path : String)
      begin
        open(path)
      rescue ex : Safe::CallError
        raise ex if ex.result != C::Enotfound
      rescue NotExactLocation
      end
    end

    def self.open(path : String)
      Safe.call :repository_open, out unsafe, path do |call|
        if call.success?
          git = new(Safe::Repository.safe(unsafe))
          expected = File.real_path(path)
          actual = File.real_path(git.path)
          raise NotExactLocation.new(expected, actual) unless actual.starts_with?(expected)
          git
        else
          call.raise!
        end
      end
    end

    def self.init(path : String, bare = false)
      Safe.call :repository_init, out unsafe, path, bare ? 1 : 0
      new(Safe::Repository.safe(unsafe))
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

    def lookup_or_create_remote(name : String, url : String)
      lookup_remote(name) || create_remote(name, url)
    end

    def create_remote(name : String, url : String)
      Safe.call :remote_create, out unsafe, @safe, name, url
      update_remotes
      Remote.new(self, Safe::Remote.safe(unsafe), name)
    end

    def update_remotes
      @remotes = nil
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

    def lookup_object(oid : Oid, type : LibC::Int = C::ObjAny)
      Safe.call :object_lookup, out obj, @safe, oid.safe, type
      Object.new(self, Safe::Object.safe(obj))
    end

    def head
      Safe.call :repository_head, out ref, @safe
      Ref.new(self, Safe::Reference.safe(ref))
    end

    def head?
      begin
        head
      rescue ex : Safe::CallError
        raise ex if ex.result != C::Eunbornbranch
      end
    end

    def set_head(refname)
      Safe.call :repository_set_head, @safe, refname
    end

    def create_ref(name, oid)
      Safe.call :reference_create, out ref, @safe, name, oid.safe.p, 0, Util.null_pstr do |call|
        if call.success?
          Ref.new(self, Safe::Reference.safe(ref))
        elsif call.result == C::Eexists
          old_ref = lookup_ref(name).not_nil!
          Safe.call :reference_set_target, out new_ref, old_ref.safe, oid.safe.p, Util.null_pstr
          Ref.new(self, Safe::Reference.safe(new_ref))
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

    def checkout(name : String, name_as : String? = nil, create = false)
      name = Ref.normalize(name)
      if ref = lookup_ref(name)
        checkout ref, name_as
      elsif create
        create_ref Ref.normalize(name_as || name), head.to_oid
      end
    end

    def checkout(ref : Ref, name_as : String? = nil)
      if treeish = parse_rev(ref.name)
        Safe.call :checkout_tree, @safe, treeish.safe, new_checkout_options.p
        name = Ref.to_local(name_as ? Ref.normalize(name_as) : ref.name)
        create_ref(name, ref.to_oid).set_head
      end
    end

    def new_checkout_options
      Safe::CheckoutOptions.init.tap do |o|
        o.checkout_strategy =
          C::CheckoutSafe |
          C::CheckoutRecreateMissing |
          C::CheckoutAllowConflicts |
          C::CheckoutSkipUnmerged |
          C::CheckoutSkipLockedDirectories |
          C::CheckoutDontOverwriteIgnored
      end
    end
  end
end
