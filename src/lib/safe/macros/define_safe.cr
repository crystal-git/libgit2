module Git::Safe
  macro included
    macro define_safe(name, value = false, free = true, dup = false)
      \{%
        camel = name.id.camelcase
        klass = value ? "Git::C::#{camel}".id : "Git::C::X_#{camel}".id
        free = "#{name.id}_free".id if free
      \%}

      \{% if value %}
        \{% if free %}
          alias Type = Value | Heap | Pointer
        \{% else %}
          alias Type = Value | Pointer
        \{% end %}
      \{% else %}
        alias Type = Heap | Pointer
      \{% end %}

      def self.null
        \{% if value %}
        \{% else %}
          pointer(::Pointer(Void).null.as(::\{{klass}}))
        \{% end %}
      end

      \{% if value %}
        class Value
          @unsafe : ::\{{klass}}

          def initialize(@unsafe)
          end

          def p
            pointerof(@unsafe)
          end

          def value
            @unsafe
          end

          def to_unsafe
            @unsafe
          end

          \{% if dup %}
            def dup
              Value.new(@unsafe)
            end
          \{% end %}
        end

        def self.value(unsafe)
          Value.new(unsafe)
        end
      \{% end %}

      \{% if free %}
        class Heap
          include ::{{@type}}

          \{% if value %}
            @unsafe : ::\{{klass}}*
          \{% else %}
            @unsafe : ::\{{klass}}
          \{% end %}

          def initialize(@unsafe)
          end

          def finalize
            ::Git::C.\{{free}} @unsafe
          end

          def to_unsafe
            @unsafe
          end

          \{% if value %}
            def p
              @unsafe
            end

            def value
              @unsafe.value
            end
          \{% end %}
        end

        def self.heap(unsafe)
          Heap.new(unsafe)
        end
      \{% end %}

      class Pointer
        include ::{{@type}}

        \{% if value %}
          @unsafe : ::\{{klass}}*
        \{% else %}
          @unsafe : ::\{{klass}}
        \{% end %}

        def initialize(@unsafe)
        end

        def p
          @unsafe
        end

        \{% if value %}
          def value
            @unsafe.value
          end
        \{% end %}

        def to_unsafe
          @unsafe
        end
      end

      def self.pointer(unsafe)
        Pointer.new(unsafe)
      end
    end
  end
end
