module Git::Safe
  module Signature
    include Safe

    define_safe :signature, value: true
  end
end
