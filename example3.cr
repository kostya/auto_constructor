require "./src/auto_constructor"

class A
  include AutoConstructor
  field :x, Int32
end

# Some user code extend this class, with another field
class A
  field :y, String
end

p A.new(1, "bla") # => #<A:0x1032d2f00 @x=1, @y="bla">
