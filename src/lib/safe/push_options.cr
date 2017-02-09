class Git::Safe
  class PushOptions
    Safe.define :push_options, type: :value, free: false

    def self.init
      co = C::PushOptions.new
      Safe.call :push_init_options, pointerof(co), C::PUSH_OPTIONS_VERSION
      safe(co)
    end

    Safe.define_value_property "callbacks.credentials"
    Safe.define_value_property "callbacks.payload"
  end
end
