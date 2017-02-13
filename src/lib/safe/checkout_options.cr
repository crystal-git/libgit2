module Git::Safe
  module CheckoutOptions
    include Safe

    define_safe :checkout_options, value: true, dup: true

    def self.init
      co = uninitialized C::CheckoutOptions
      Safe.call :checkout_init_options, pointerof(co), C::CHECKOUT_OPTIONS_VERSION
      value(co)
    end
  end
end
