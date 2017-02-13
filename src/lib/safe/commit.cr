module Git::Safe
  module Commit
    include Safe

    define_safe :commit
  end
end
