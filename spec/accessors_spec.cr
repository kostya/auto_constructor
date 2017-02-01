require "./spec_helper"

class Accessor1
  include AutoConstructor
  field x, Int32, getter: false
end

class Accessor2
  include AutoConstructor
  field x, Int32, setter: false
end

class Accessor3
  include AutoConstructor
  field x, Int32, setter: false, getter: false
end

class Accessor4
  include AutoConstructor
  field x, Int32, accessor: "@"
end

class Accessor5
  include AutoConstructor
  field x, Int32, accessor: "property "
end

describe AutoConstructor do
  context "accessors" do
    it do
      a = Accessor1.new(1)
      a.x = 2
      a.@x.should eq 2
    end

    it { Accessor2.new(1).x.should eq 1 }
    it { Accessor3.new(1).@x.should eq 1 }
    it { Accessor4.new(1).@x.should eq 1 }

    it do
      a = Accessor5.new(1)
      a.x.should eq 1
      a.x = 2
      a.x.should eq 2
    end
  end
end
