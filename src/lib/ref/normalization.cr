module Git
  class Ref
    REFS_REMOTES_REMOTE = /^refs\/remotes\/([^\/]+)\/(.+)$/
    REMOTES_REMOTE = /^remotes\/(^\/]+)\/(.+)$/
    REFS_HEADS = /^refs\/heads\/(.+)$/

    def self.remote?(name)
      normalize(name).starts_with?("/refs/remotes/")
    end

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
      name = normalize(name)
      if name.starts_with?("refs/remotes/#{remote}/")
        name
      elsif name.starts_with?("remotes/#{remote}/")
        "refs/#{name}"
      elsif name.starts_with?("#{remote}/")
        "refs/remotes/#{name}"
      elsif REFS_HEADS =~ name
        "refs/remotes/#{remote}/#{$1}"
      else
        name
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
