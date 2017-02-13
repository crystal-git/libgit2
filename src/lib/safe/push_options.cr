module Git::Safe
  module PushOptions
    include Safe

    define_safe :push_options, value: true, free: false

    def self.init
      co = uninitialized C::PushOptions
      Safe.call :push_init_options, pointerof(co), C::PUSH_OPTIONS_VERSION
      value(co)
    end
  end
end
