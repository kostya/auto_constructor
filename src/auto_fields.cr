module AutoFields
  VERSION = "0.4"

  macro included
    {% if !@type.constant :AUTO_CONSTRUCTOR_FIELDS %}
      AUTO_CONSTRUCTOR_FIELDS = [] of Nil
      AFTER_INITIALIZE = [] of Nil
    {% end %}

    # options:
    #   :name
    #   :type
    #   :default
    #   :getter (enabled by default, false to disable)
    #   :setter (enabled by default, false to disable)
    macro field(name, type, **opts)
      \{%
        opts[:name] = name
        opts[:type] = type
        if opts[:accessor] == nil
          opts[:accessor] = if (opts[:getter] == false) && (opts[:setter] == false)
            "@"
          elsif opts[:getter] == false
            "setter "
          elsif opts[:setter] == false
            "getter "
          else
            "property "
          end
        end
        if opts[:nilable] == nil
          # TODO: this too hackety, rewrite somehow, or use :nilable option directly
          opts[:nilable] = (type.stringify =~ /(\s\|\s|^|Union.+?)\(?(::)?Nil\)?/)
        end
        AUTO_CONSTRUCTOR_FIELDS << opts
      %}
    end

    macro finished
      \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
        \{{field[:accessor].id}}\{{field[:name].id}} : \{{field[:type].id}}
      \{% end %}

      def to_tuple
        Tuple.new(
          \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
            @\{{field[:name].id}},
          \{% end %}
        )
      end

      def to_named_tuple
        NamedTuple.new(
          \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
            \{{field[:name].id}}: @\{{field[:name].id}},
          \{% end %}
        )
      end
    end

    macro inherited
      \{% if !@type.has_constant?(:AUTO_CONSTRUCTOR_FIELDS) %}
        include AutoConstructor
        \{% for x in AUTO_CONSTRUCTOR_FIELDS %}
          \\{% AUTO_CONSTRUCTOR_FIELDS << \{{x}} %}
        \{% end %}
      \{% end %}
    end

    macro included
      \{% if !@type.has_constant?(:AUTO_CONSTRUCTOR_FIELDS) %}
        include AutoConstructor
        \{% for x in AUTO_CONSTRUCTOR_FIELDS %}
          \\{% AUTO_CONSTRUCTOR_FIELDS << \{{x}} %}
        \{% end %}
      \{% end %}
    end
  end
end
