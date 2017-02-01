require "./spec_helper"

struct UnionTest
  include AutoConstructor

  field :a, Int32 | String
end

describe AutoConstructor do
  it { UnionTest.new(1).a.should eq 1 }
  it { UnionTest.new("1").a.should eq "1" }
  it { UnionTest.new(a: 1).a.should eq 1 }
  it { UnionTest.new(a: "1").a.should eq "1" }
end
