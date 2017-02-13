module Git::Safe
  module Oid
    include Safe

    define_safe :oid, value: true, free: false
  end
end
