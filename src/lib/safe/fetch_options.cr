class Git::Safe
  class FetchOptions
    Safe.define :fetch_options, type: :value, free: false

    def self.init
      fo = C::FetchOptions.new
      Safe.call :fetch_init_options, pointerof(fo), C::FETCH_OPTIONS_VERSION
      safe(fo)
    end
  end
end
