module Git
  class Ref
    getter repo : Repo
    getter safe : Safe::Reference

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
      repo.ref_name_to_oid(name)
    end

    def to_oid
      to_oid?.not_nil!
    end

    REFS_REMOTES_REMOTE = /^refs\/remotes\/([^\/]+)\/(.+)$/
    REMOTES_REMOTE = /^remotes\/(^\/]+)\/(.+)$/

    def self.normalize(name)
      if REFS_REMOTES_REMOTE =~ name
        name
      elsif REMOTES_REMOTE =~ name
        "refs/remotes/#{$1}/#{$2}"
      elsif name.starts_with?("refs/heads/") || name.starts_with?("refs/tags/")
        name
      elsif name.starts_with?("heads/") || name.starts_with?("tags/")
        "refs/#{name}"
      else
        "refs/heads/#{name}"
      end
    end

    def self.normalize_remote(name, remote)
      if name.starts_with?("refs/remotes/#{remote}/")
        name
      elsif name.starts_with?("remotes/#{remote}/")
        "refs/#{name}"
      elsif name.starts_with?("#{remote}/")
        "refs/remotes/#{name}"
      else
        "refs/remotes/#{remote}/#{name}"
      end
    end

    def self.to_local(name)
      name = normalize(name)
      if REFS_REMOTES_REMOTE =~ name
        "refs/heads/#{$2}"
      elsif REFS_REMOTES_REMOTE =~ name
        "refs/heads/#{$2}"
      else
        name
      end
    end
  end
end
