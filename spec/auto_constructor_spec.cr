require "./spec_helper"

class DoubleInclude
  include AutoConstructor
  include AutoConstructor
  field x, Int32
end

describe AutoConstructor do
  context "DoubleInclude" do
    it do
      a = DoubleInclude.new(1)
      a.x.should eq 1
    end
  end
end
