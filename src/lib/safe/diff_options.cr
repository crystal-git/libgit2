module Git::Safe
  module DiffOptions
    include Safe

    define_safe :diff_options, value: true, free: false

    def self.init
      fo = uninitialized C::DiffOptions
      Safe.call :diff_init_options, pointerof(fo), C::DIFF_OPTIONS_VERSION
      value(fo)
    end
  end
end
