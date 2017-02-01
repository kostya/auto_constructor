require "./spec_helper"

class AutoExpand
  include AutoConstructor
  field :x, Int32
end

class AutoExpand
  field :y, String
end

describe AutoConstructor do
  context "auto expand class" do
    it do
      a = AutoExpand.new(1, "bla")
      a.x.should eq 1
      a.y.should eq "bla"
    end
  end
end
