module Git::Util
  struct Var(T)
    property! var : T?

    def initialize(@var)
    end
  end
end
