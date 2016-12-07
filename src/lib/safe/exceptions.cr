class Git::Safe
  class CallError < Git::Exception
    def initialize(function_name, result, error)
      super "libgit2 error: #{function_name} #{result}/#{error.value.klass} #{String.new(error.value.message)}"
    end
  end
end
