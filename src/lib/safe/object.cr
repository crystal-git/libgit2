module Git::Safe
  module Object
    include Safe

    define_safe :object
  end
end
