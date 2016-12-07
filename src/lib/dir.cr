module Git
  class Dir
    getter path : String

    def initialize(@path)
    end

    @repo : Repo?
    def repo
      @repo ||= Repo.from_path(path)
    end
  end
end
