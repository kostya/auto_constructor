require "./spec_helper"

class DoubleInclude
  include AutoConstructor
  include AutoConstructor
  field x, Int32
end

struct AutoConstructorSimple
  include AutoConstructor

  field :a, Int32
  field :b, String
  field :c, Float64?
end

describe AutoConstructor do
  context "DoubleInclude" do
    it do
      a = DoubleInclude.new(1)
      a.x.should eq 1
    end
  end

  it "to_tuple" do
    AutoConstructorSimple.new(1, "bla").to_tuple.should eq({1, "bla", nil})
    AutoConstructorSimple.new(1, "bla", 1.0).to_tuple.should eq({1, "bla", 1.0})
  end

  it "to_named_tuple" do
    AutoConstructorSimple.new(1, "bla").to_named_tuple.should eq({a: 1, b: "bla", c: nil})
    AutoConstructorSimple.new(1, "bla", 1.0).to_named_tuple.should eq({a: 1, b: "bla", c: 1.0})
  end
end
