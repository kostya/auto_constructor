require "./spec_helper"

struct Simple
  include AutoConstructor

  field :a, Int32
end

describe AutoConstructor do
  context "simple" do
    it { Simple.new(10).a.should eq 10 }
    it { Simple.new(a: 10).a.should eq 10 }
  end
end
