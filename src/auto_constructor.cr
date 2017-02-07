require "./auto_fields"

module AutoConstructor
  VERSION = "0.4"

  macro included
    include AutoFields

    macro after_initialize(&block)
      \{% AFTER_INITIALIZE << block.body %}
    end

    macro finished
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
    end
  end
end
