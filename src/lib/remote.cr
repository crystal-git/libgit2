module Git
  class Remote
    getter repo : Repo
    @safe : Safe::Remote
    getter name : String

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

    def checkout(remote_name : String)
      remote_name = "refs/remotes/#{self.name}/#{remote_name}" unless remote_name.starts_with?("refs/remotes/#{self.name}/")
      if ref = repo.lookup_ref(remote_name)
        if ref.remote?
          checkout ref
          return
        end
      end
      local = remote_name.sub(/^refs\/remotes\/#{name}/, "refs/heads")
      fetch ["#{local}:#{remote_name}"]
      if ref = repo.lookup_ref(remote_name)
        if ref.remote?
          checkout ref
        end
      end
    end

    def checkout(remote_ref : Ref)
      local = remote_ref.name.sub(/^refs\/remotes\/#{name}/, "refs/heads")
      ref = repo.create_ref(local, remote_ref.to_oid)
      ref.head!
    end

    def fetch(refspecs = nil, options = nil)
      refspecs = Safe::StaticStrarray.new(refspecs || %w())
      options ||= Safe::FetchOptions.init
      Safe.call :remote_fetch, @safe, refspecs, options.p, Util.null_pstr
    end

    # @service : RemoteService?
    # def service
    #   @service ||= resolve_service
    # end
    #
    # def resolve_service
    #   if fetch_url.host == "github.com"
    #     RemoteServices::Github.new(self)
    #   else
    #     RemoteServices::Unknown.new(self)
    #   end
    # end
  end
end
