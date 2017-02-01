struct NamedTuple
  def blo?(key : Symbol | String)
    {% for key in T %}
      return true if {{key.symbolize}} == key
    {% end %}
    false
  end
end

module AutoConstructor
  VERSION = "0.1"

  macro included
    AUTO_CONSTRUCTOR_FIELDS = [] of Nil
    AFTER_INITIALIZE = [] of Nil

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
        unless opts[:accessor]
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
        AUTO_CONSTRUCTOR_FIELDS << opts
      %}
    end

    macro after_initialize(&block)
      \{%
        AFTER_INITIALIZE << block.body
      %}
    end

    macro finished
      \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
        \{{field[:accessor].id}}\{{field[:name].id}} : \{{field[:type].id}}
      \{% end %}

      def initialize(**args)
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          \{% if field[:default] %}
            @\{{field[:name].id}} = args[:\{{field[:name].id}}]? || \{{field[:default]}}
          \{% else %}
            @\{{field[:name].id}} = args[:\{{field[:name].id}}]?
          \{% end%}
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end

      def initialize(*args)
        \{% i = 0 %}
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          @\{{field[:name].id}} = args[\{{i}}]? \{{ field[:default] ? "|| #{field[:default]}".id : "".id }}
          \{% i = i + 1 %}
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end

      # raises runtime error, on incorrect type
      def initialize(h : Hash(String, T)) forall T
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          @\{{field[:name].id}} = (h[\{{field[:name].id.stringify}}]?\{{ field[:default] ? "|| #{field[:default]}".id : "".id }}).as(\{{field[:type].id}})
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end

      # raises runtime error, on incorrect type
      def initialize(h : Hash(Symbol, T)) forall T
        \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
          @\{{field[:name].id}} = (h[:\{{field[:name].id}}]?\{{ field[:default] ? "|| #{field[:default]}".id : "".id }}).as(\{{field[:type].id}})
        \{% end %}
        \{% for ai in AFTER_INITIALIZE %} \{{ ai.id }} \{% end %}
      end
    end
  end
end
