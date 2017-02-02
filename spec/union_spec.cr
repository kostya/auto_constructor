require "./spec_helper"

struct UnionTest
  include AutoConstructor

  field :a, Int32 | String
end

struct UnionTestNil
  include AutoConstructor

  field :a, Int32 | String | Nil, default: nil
end

describe AutoConstructor do
  it { UnionTest.new(1).a.should eq 1 }
  it { UnionTest.new("1").a.should eq "1" }
  it { UnionTest.new(a: 1).a.should eq 1 }
  it { UnionTest.new(a: "1").a.should eq "1" }

  it { UnionTestNil.new(1).a.should eq 1 }
  it { UnionTestNil.new("1").a.should eq "1" }
  it { UnionTestNil.new.a.should eq nil }
end
