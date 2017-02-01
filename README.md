# auto_constructor

Auto construct initialize methods for classes and structs

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  auto_constructor:
    github: kostya/auto_constructor
```

## Usage

```crystal
require "auto_constructor"

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
```

## Fields options

```
  :default - set default value
  :getter - (enabled by default, false to disable)
  :setter - (enabled by default, false to disable)
```

## After initialize hook

```crystal
require "auto_constructor"

class A
  include AutoConstructor
  field :x, Int32

  property y : Int32

  after_initialize do
    @y = @x + 1
  end
end

p A.new(1) # => #<A:0x10befc0 @x=1, @y=2>
```
