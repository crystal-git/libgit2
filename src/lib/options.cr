module Git
  module Options
    macro extended
      {%
        name = @type.name.split("::").last.id
      %}

      getter safe : ::Git::Safe::{{name}}::Type

      def initialize(@safe)
      end

      def initialize
        initialize ::Git::Safe::{{name}}.init
      end

      def dup
        {{name}}.new(@safe.dup)
      end

      def value
        @safe.value
      end

      def p
        @safe.p
      end
    end
  end
end
