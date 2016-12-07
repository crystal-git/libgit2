class Git::Safe
  class CheckoutOptions
    Safe.define :checkout_options, type: :value, free: false

    def self.init
      co = C::CheckoutOptions.new
      Safe.call :checkout_init_options, pointerof(co), C::CHECKOUT_OPTIONS_VERSION
      safe(co)
    end

    Safe.define_value_property :checkout_strategy
  end
end
