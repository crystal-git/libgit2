module Git
  class Remote
    getter repo : Repo
    getter safe : Safe::Remote::Type
    getter name : String
    property? fetch_credential : Credentials::Base?
    property? push_credential : Credentials::Base?
    property? fetch_options : FetchOptions?
    property? push_options : PushOptions?

    def initialize(@repo, @safe, @name)
    end

    @fetch_url : Url?
    def fetch_url
      @fetch_url ||= Url.parse(Safe.string(:remote_url, @safe))
    end

    @push_url = Util::Memo(Url?).new
    def push_url?
      @push_url.memo do
        if s = Safe.string_or_nil(:remote_pushurl, @safe)
          Url.parse(s)
        end
      end
    end

    @fetch_refspecs : Array(Refspec)?
    def fetch_refspecs
      @fetch_refspecs ||= ([] of Refspec).tap do |a|
        sa = uninitialized C::Strarray
        Safe.call :remote_get_fetch_refspecs, pointerof(sa), @safe
        sa.each do |s|
          a << repo.lookup_reference(s).not_nil!
        end
      end
    end

    # Creates a reference that points to the corresponding remote reference.
    def create_ref?(name : String, non_fast_forward = true)
      remotename = Ref.to_remote(name, self.name)
      localname = Ref.to_local(name)
      remote = repo.lookup_ref?(remotename) || begin
        plus = non_fast_forward ? "+" : ""
        fetch "#{plus}#{localname}:#{localname}"
        repo.lookup_ref?(remotename)
      end
      remote && repo.create_ref(localname, remote.to_oid, force: true)
    end

    def fetch(refspec : String)
      fetch [refspec]
    end

    def fetch(refspecs : Array(String)? = nil, options : FetchOptions? = nil, credential : Credentials::Base? = nil)
      refspecs = Safe::StaticStrarray.new(refspecs || %w())
      options ||= fetch_options? || FetchOptions.new
      options = options.dup
      credential ||= fetch_credential? || default_fetch_credential
      pl = new_callback_payload(credential)
      options.p.value.callbacks.credentials = credential.callback
      options.p.value.callbacks.payload = Box.box(pl)
      Safe.call :remote_fetch, @safe, refspecs, options.p, Util.null_pstr
    end

    # def pull(remote_name, name_as = nil, create = false)
    #   checkout remote_name, name_as: name_as, create: create, force_fetch: true
    # end

    def push(refspec : String)
      push [refspec]
    end

    def push(refspecs : Array(String)? = nil, options : PushOptions? = nil, credential : Credentials::Base? = nil)
      refspecs = Safe::StaticStrarray.new(refspecs || %w())
      options ||= push_options? || PushOptions.new
      options = options.dup
      credential ||= push_credential? || default_push_credential
      pl = new_callback_payload(credential)
      options.p.value.callbacks.credentials = credential.callback
      options.p.value.callbacks.payload = Box.box(pl)
      Safe.call :remote_push, @safe, refspecs, options.p
    end

    def new_callback_payload(credential)
      pl = CallbackPayload.new
      pl.remote = self
      pl.credential = credential
      pl
    end

    @default_fetch_credential : Credentials::SshKey?
    def default_fetch_credential
      @default_fetch_credential ||= Credentials::SshKey.new(username: fetch_url.user?)
    end

    @default_push_credential : Credentials::SshKey?
    def default_push_credential
      @default_push_credential ||= Credentials::SshKey.new(username: (push_url? || fetch_url).user?)
    end
  end
end
