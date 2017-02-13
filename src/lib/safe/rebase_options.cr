module Git::Safe
  module RebaseOptions
    include Safe

    define_safe :rebase_options, value: true, free: false

    def self.init
      co = uninitialized C::RebaseOptions
      Safe.call :rebase_init_options, pointerof(co), C::REBASE_OPTIONS_VERSION
      value(co)
    end
  end
end
