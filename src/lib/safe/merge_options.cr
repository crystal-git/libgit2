module Git::Safe
  module MergeOptions
    include Safe

    define_safe :merge_options, value: true, free: false, dup: true

    def self.init
      co = uninitialized C::MergeOptions
      Safe.call :merge_init_options, pointerof(co), C::MERGE_OPTIONS_VERSION
      value(co)
    end
  end
end
