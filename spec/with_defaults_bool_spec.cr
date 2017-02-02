require "./spec_helper"

struct WithDefaultsBoolTrue
  include AutoConstructor
  field :x, Bool, default: true
end

struct WithDefaultsBoolFalse
  include AutoConstructor
  field :x, Bool, default: false
end

describe "AutoConstructor" do
  context "WithDefaultsBoolTrue" do
    it { WithDefaultsBoolTrue.new(true).x.should eq true }
    it { WithDefaultsBoolTrue.new.x.should eq true }
    it { WithDefaultsBoolTrue.new(false).x.should eq false }

    it { WithDefaultsBoolTrue.new(x: true).x.should eq true }
    it { WithDefaultsBoolTrue.new(x: false).x.should eq false }
    it { WithDefaultsBoolTrue.new(y: false).x.should eq true }

    it { WithDefaultsBoolTrue.new({:x => true}).x.should eq true }
    it { WithDefaultsBoolTrue.new({:x => false}).x.should eq false }
    it { WithDefaultsBoolTrue.new({:y => nil}).x.should eq true }

    it { WithDefaultsBoolTrue.new({"x" => true}).x.should eq true }
    it { WithDefaultsBoolTrue.new({"x" => false}).x.should eq false }
    it { WithDefaultsBoolTrue.new({"y" => nil}).x.should eq true }
  end

  context "WithDefaultsBoolFalse" do
    it { WithDefaultsBoolFalse.new(true).x.should eq true }
    it { WithDefaultsBoolFalse.new.x.should eq false }
    it { WithDefaultsBoolFalse.new(false).x.should eq false }

    it { WithDefaultsBoolFalse.new(x: true).x.should eq true }
    it { WithDefaultsBoolFalse.new(x: false).x.should eq false }
    it { WithDefaultsBoolFalse.new(y: false).x.should eq false }

    it { WithDefaultsBoolFalse.new({:x => true}).x.should eq true }
    it { WithDefaultsBoolFalse.new({:x => false}).x.should eq false }
    it { WithDefaultsBoolFalse.new({:y => nil}).x.should eq false }

    it { WithDefaultsBoolFalse.new({"x" => true}).x.should eq true }
    it { WithDefaultsBoolFalse.new({"x" => false}).x.should eq false }
    it { WithDefaultsBoolFalse.new({"y" => nil}).x.should eq false }
  end
end
