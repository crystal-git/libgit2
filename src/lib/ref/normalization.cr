module Git
  class Ref
    REFS_REMOTES_REMOTE = /^refs\/remotes\/([^\/]+)\/(.+)$/
    REMOTES_REMOTE = /^remotes\/(^\/]+)\/(.+)$/
    REFS_HEADS = /^refs\/heads\/(.+)$/
    REFS_TAGS = /^refs\/tags\/(.+)$/
    REFS_REMOTES = /^refs\/remotes\/(.+)$/
    SPECIAL_HEADS = %w(HEAD ORIG_HEAD FETCH_HEAD MERGE_HEAD)

    def self.normalize(name : String, &block : -> String)
      if name.starts_with?("refs/remotes") =~ name
        name
      elsif name.starts_with?("remotes/")
        "refs/#{name}"
      elsif name.starts_with?("refs/heads/") || name.starts_with?("refs/tags/")
        name
      elsif name.starts_with?("heads/") || name.starts_with?("tags/")
        "refs/#{name}"
      elsif SPECIAL_HEADS.includes?(name)
        name
      else
        yield
      end
    end

    def self.normalize(name : String)
      normalize(name) do
        "refs/heads/#{name}"
      end
    end

    def self.to_remote(name : String, remote : String, &block : -> String)
      name = normalize(name)
      if name.starts_with?("refs/remotes/#{remote}/")
        name
      elsif name.starts_with?("remotes/#{remote}/")
        "refs/#{name}"
      elsif name.starts_with?("#{remote}/")
        "refs/remotes/#{name}"
      elsif REFS_HEADS =~ name
        "refs/remotes/#{remote}/#{$1}"
      elsif SPECIAL_HEADS.includes?(name)
        "refs/remotes/#{remote}/#{name}"
      else
        yield
      end
    end

    def self.to_remote(name : String, remote : String)
      to_remote(name, remote) do
        name
      end
    end

    def self.to_local(name : String, &block : -> String)
      name = normalize(name)
      if REFS_REMOTES_REMOTE =~ name || REFS_REMOTES_REMOTE =~ name
        name = $2
        if SPECIAL_HEADS.includes?(name)
          name
        else
          "refs/heads/#{$2}"
        end
      else
        yield
      end
    end

    def self.to_local(name : String)
      to_local(name) do
        name
      end
    end

    def self.shorten(name : String, &block : -> String)
      name = normalize(name)
      if REFS_HEADS =~ name
        $1
      elsif REFS_TAGS =~ name
        $1
      elsif REFS_REMOTES =~ name
        $1
      else
        yield
      end
    end

    def self.shorten(name : String)
      shorten(name) do
        name
      end
    end
  end
end
