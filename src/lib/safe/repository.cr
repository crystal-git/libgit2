module Git::Safe
  module Repository
    include Safe

    define_safe :repository
  end
end
