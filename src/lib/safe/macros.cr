class Git::Safe
  macro define(name, type = :reference, free = true)
    {%
      raise "invalid type: #{type}" if type != :reference && type != :value
      klass = type == :reference ? "::Git::C::X_#{name.id.camelcase}".id : "::Git::C::#{name.id.camelcase}".id
      free = "#{name.id}_free".id if free
    %}

    @safe : Safe({{klass}})

    private def initialize(@safe)
    end

    {% if free %}
      def finalize
        unless @safe.const?
          {% if type == :reference %}
            ::Git::C.{{free}} self
          {% else %}
            ::Git::C.{{free}} p
          {% end %}
        end
      end
    {% end %}

    {% if type == :reference %}
      def to_unsafe
        unsafe
      end

      def unsafe
        @safe.unsafe
      end
    {% else %}
      def p
        @safe.p
      end
    {% end %}

    def self.safe(unsafe)
      new(Safe.non_const(unsafe))
    end

    def with_safe
      with @safe yield
    end
  end

  macro define_value_property(name)
    def {{name.id}}
      with_safe do
        unsafe.{{name.id}}
      end
    end

    def {{name.id}}=(v)
      with_safe do
        unsafe.{{name.id}} = v
      end
    end
  end

  macro call(f, *args, &block)
    %result = C.{{f.id}}({{args.splat}})
    {% if block %}
      %call = ::Git::Safe::Call.new({{f.id.stringify}}, %result, C.giterr_last)
      ::Git::Util.yield_with(%call) {{block}}
    {% else %}
      raise ::Git::Safe::CallError.new({{f.id.stringify}}, %result, C.giterr_last) if %result < 0
    {% end %}
  end

  macro string(f, *args)
    String.new(C.{{f.id}}({{args.splat}}))
  end

  macro string_or_nil(f, *args)
    result = C.{{f.id}}({{args.splat}})
    result == Pointer(UInt8).null ? nil : String.new(result)
  end
end
