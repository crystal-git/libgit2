module Git::Safe
  macro extended
    extend ::Safec::Macros

    macro define_x(name)
      \{%
        name = name.id
        camel = name.camelcase
        klass = "Git::C::X_#{camel}".id
      \%}

      safe_c_pointer ::\{{klass}}

      class Free
        def free(p)
          ::Git::C.\{{name}}_free p
        end
      end
    end

    macro define_struct(name)
      \{%
        name = name.id
        camel = name.camelcase
        upcase = name.upcase
        klass = "Git::C::#{camel}".id
      \%}

      safe_c_struct ::\{{klass}}

      class Free
        def free(p)
          ::Git::C.\{{name}}_free p
        end
      end
    end

    macro define_options(name)
      \{%
        name = name.id
        fullname = "#{name}_options".id
        camel = fullname.camelcase
        upcase = fullname.upcase
        klass = "Git::C::#{camel}".id
      \%}

      safe_c_struct ::\{{klass}}, free: false

      def self.init
        v = uninitialized ::\{{klass}}
        ::Git::Safe.call :\{{name}}_init_options, pointerof(v), ::Git::C::\{{upcase}}_VERSION
        value(v)
      end
    end
  end
end
