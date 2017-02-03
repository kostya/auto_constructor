module AutoConstructor
  VERSION = "0.3"

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

    macro after_initialize(&block)
      \{% AFTER_INITIALIZE << block.body %}
    end

    macro finished
      \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
        \{{field[:accessor].id}}\{{field[:name].id}} : \{{field[:type].id}}
      \{% end %}

      def initialize(**args)
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          _\{{field[:name].id}} = args[:\{{field[:name].id}}]?
          \{% if field[:nilable] %}
            @\{{field[:name].id}} = args.has_key?(:\{{field[:name].id}}) ? _\{{field[:name].id}} : \{{field[:default]}}
          \{% elsif field[:default] != nil %}
            @\{{field[:name].id}} = _\{{field[:name].id}}.is_a?(Nil) ? \{{field[:default]}} : _\{{field[:name].id}}
          \{% else %}
            @\{{field[:name].id}} = _\{{field[:name].id}}
          \{% end%}
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end

      def initialize(*args)
        \{% i = 0 %}
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          _\{{field[:name].id}} = args[\{{i}}]?
          \{% if field[:nilable] %}
            @\{{field[:name].id}} = _\{{field[:name].id}}
          \{% elsif field[:default] != nil %}
            @\{{field[:name].id}} = _\{{field[:name].id}}.is_a?(Nil) ? \{{field[:default]}} : _\{{field[:name].id}}
          \{% else %}
            @\{{field[:name].id}} = _\{{field[:name].id}}
          \{% end%}
          \{% i = i + 1 %}
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end

      # raises runtime error, on incorrect type
      def initialize(h : Hash(String, T)) forall T
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          _\{{field[:name].id}} = h[\{{field[:name].id.stringify}}]?
          \{% if field[:nilable] %}
            _2\{{field[:name].id}} = h.has_key?(\{{field[:name].id.stringify}}) ? _\{{field[:name].id}} : \{{field[:default]}}
          \{% elsif field[:default] != nil %}
            _2\{{field[:name].id}} = _\{{field[:name].id}}.is_a?(Nil) ? \{{field[:default]}} : _\{{field[:name].id}}
          \{% else %}
            _2\{{field[:name].id}} = _\{{field[:name].id}}
          \{% end%}
          @\{{field[:name].id}} = _2\{{field[:name].id}}.as(\{{field[:type].id}})
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end

      # raises runtime error, on incorrect type
      def initialize(h : Hash(Symbol, T)) forall T
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          _\{{field[:name].id}} = h[:\{{field[:name].id}}]?
          \{% if field[:nilable] %}
            _2\{{field[:name].id}} = h.has_key?(:\{{field[:name].id}}) ? _\{{field[:name].id}} : \{{field[:default]}}
          \{% elsif field[:default] != nil %}
            _2\{{field[:name].id}} = _\{{field[:name].id}}.is_a?(Nil) ? \{{field[:default]}} : _\{{field[:name].id}}
          \{% else %}
            _2\{{field[:name].id}} = _\{{field[:name].id}}
          \{% end%}
          @\{{field[:name].id}} = _2\{{field[:name].id}}.as(\{{field[:type].id}})
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end

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
      \{% if !@type.constant :AUTO_CONSTRUCTOR_FIELDS %}
        include AutoConstructor
        \{% for x in AUTO_CONSTRUCTOR_FIELDS %}
          \\{% AUTO_CONSTRUCTOR_FIELDS << \{{x}} %}
        \{% end %}
      \{% end %}
    end
  end
end
