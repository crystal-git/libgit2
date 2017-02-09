module Git
  class Remote
    getter repo : Repo
    @safe : Safe::Remote
    getter name : String
    property! credential : Credentials::Base?

    def initialize(@repo, @safe, @name)
    end

    @fetch_url : Url?
    def fetch_url
      @fetch_url ||= Url.parse(Safe.string(:remote_url, @safe))
    end

    @push_url : Util::Var(Url)?
    def push_url?
      var = (@push_url ||= Util::Var(Url).new((begin
        if s = Safe.string_or_nil(:remote_pushurl, @safe)
          Url.parse(s)
        end
      end)))
      var.var?
    end

    def push_url
      push_url?.not_nil!
    end

    @fetch_refspecs : Array(Refspec)?
    def fetch_refspecs
      @fetch_refspecs ||= ([] of Refspec).tap do |a|
        sa = C::Strarray.new
        Safe.call :remote_get_fetch_refspecs, pointerof(sa), @safe
        sa.each do |s|
          a << repo.lookup_reference(s).not_nil!
        end
      end
    end

    def checkout(remote_name, name_as = nil, create = false, force_fetch = false)
      remote_name = Ref.normalize_remote(remote_name, name)
      unless force_fetch
        if ref = repo.lookup_ref(remote_name)
          if ref.remote?
            checkout ref, name_as
            return
          end
        end
      end
      local_name = Ref.to_local(remote_name)
      fetch "+#{local_name}:#{remote_name}"
      if ref = repo.lookup_ref(remote_name)
        if ref.remote?
          checkout ref, name_as
          return
        end
      end
      repo.checkout name_as || local_name, create: create
    end

    def checkout(remote_ref : Ref, name_as = nil)
      name_as ||= Ref.to_local(remote_ref.name)
      repo.checkout remote_ref, name_as
    end

    def fetch(refspec : String)
      fetch [refspec]
    end

    def fetch(refspecs : Array(String)? = nil)
      refspecs = Safe::StaticStrarray.new(refspecs || %w())
      with_callback_payload do |pl, box|
        opts = Safe::FetchOptions.init
        opts.callbacks__credentials = pl.credential.callback
        opts.callbacks__payload = box
        opts
        Safe.call :remote_fetch, @safe, refspecs, opts.p, Util.null_pstr
      end
    end

    def pull(remote_name, name_as = nil, create = false)
      checkout remote_name, name_as: name_as, create: create, force_fetch: true
    end

    def push(refspec : String)
      push [refspec]
    end

    def push(refspecs : Array(String)? = nil)
      refspecs ||= %w()
      refspecs = Safe::StaticStrarray.new(refspecs)
      with_callback_payload do |pl, box|
        opts = Safe::PushOptions.init
        opts.callbacks__credentials = pl.credential.callback
        opts.callbacks__payload = box
        Safe.call :remote_push, @safe, refspecs, opts.p
      end
    end

    def with_callback_payload
      CallbackPayload.box do |pl, box|
        pl.remote = self
        pl.credential = credential? || repo.credential? || Credentials::DefaultSshKey.instance
        yield pl, box
      end
    end
  end
end
