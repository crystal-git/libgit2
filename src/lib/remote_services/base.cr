module Git::RemoteServices
  abstract class Base
    getter remote : Remote

    def initialize(@remote)
    end
  end
end
