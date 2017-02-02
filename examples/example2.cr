require "../src/auto_constructor"

class A
  include AutoConstructor
  field :x, Int32

  property y : Int32

  after_initialize do
    @y = @x + 1
  end
end

p A.new(1) # => #<A:0x10befc0 @x=1, @y=2>
