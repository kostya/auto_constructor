require "../src/auto_constructor"

struct A
  include AutoConstructor

  field :a, Int32
  field :b, String, default: "def"
  field :c, Int32
  field :d, String?
  field :e, Float64
end

p A.new(1, "what", 3, "bla", 1.0)                # => A(@a=1, @b="what", @c=3, @d="bla", @e=1.0)
p A.new(a: 1, b: "what", c: 3, d: "bla", e: 1.0) # => A(@a=1, @b="what", @c=3, @d="bla", @e=1.0)
p A.new(a: 1, c: 3, e: 1.0)                      # => A(@a=1, @b="def", @c=3, @d=nil, @e=1.0)
p A.new({:a => 1, :c => 3, :e => 1.0})           # => A(@a=1, @b="def", @c=3, @d=nil, @e=1.0)
p A.new({"a" => 1, "c" => 3, "e" => 1.0})        # => A(@a=1, @b="def", @c=3, @d=nil, @e=1.0)
