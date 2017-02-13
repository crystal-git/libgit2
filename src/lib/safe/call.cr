module Git::Safe
  struct Call
    getter function_name : String
    getter result : LibC::Int
    getter error : C::GitError*

    def initialize(@function_name, @result, @error)
    end

    def error?
      @result < 0
    end

    def success?
      !error?
    end

    def raise!
      raise CallError.new(function_name, result, error)
    end
  end
end
