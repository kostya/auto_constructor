require "./spec_helper"

class NilableAndDefault
  include AutoConstructor
  field :x, Int32?, default: 1
end

describe AutoConstructor do
  it { NilableAndDefault.new(2).x.should eq 2 }
  it { NilableAndDefault.new.x.should eq 1 }
  it { NilableAndDefault.new(nil).x.should eq nil }

  it { NilableAndDefault.new(x: 2).x.should eq 2 }
  it { NilableAndDefault.new(x: nil).x.should eq nil }

  it { NilableAndDefault.new({:x => 2}).x.should eq 2 }
  it { NilableAndDefault.new({:x => nil}).x.should eq nil }

  it { NilableAndDefault.new({"x" => 2}).x.should eq 2 }
  it { NilableAndDefault.new({"x" => nil}).x.should eq nil }
end
