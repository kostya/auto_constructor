require "../src/auto_constructor"

class A
  include AutoConstructor
  field x, Int32
end

A.new("")
