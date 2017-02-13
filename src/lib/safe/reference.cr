module Git::Safe
  module Reference
    include Safe

    define_safe :reference
  end
end
