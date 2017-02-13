module Git::Safe
  module FetchOptions
    include Safe

    define_safe :fetch_options, value: true, free: false

    def self.init
      fo = uninitialized C::FetchOptions
      Safe.call :fetch_init_options, pointerof(fo), C::FETCH_OPTIONS_VERSION
      value(fo)
    end
  end
end
