require "./spec_helper"

struct Bool1
  include AutoConstructor
  field :x, Bool
end

struct Nil1
  include AutoConstructor
  field :x, Nil
end

describe "AutoConstructor" do
  context "Bool1" do
    it { Bool1.new(true).x.should eq true }
    it { Bool1.new(false).x.should eq false }

    it { Bool1.new(x: true).x.should eq true }
    it { Bool1.new(x: false).x.should eq false }

    it { Bool1.new({:x => true}).x.should eq true }
    it { Bool1.new({:x => false}).x.should eq false }

    it { Bool1.new({"x" => true}).x.should eq true }
    it { Bool1.new({"x" => false}).x.should eq false }
  end

  context "Nil1" do
    it { Nil1.new(nil).x.should eq nil }
    it { Nil1.new(x: nil).x.should eq nil } 
    it { Nil1.new({:x => nil}).x.should eq nil }
    it { Nil1.new({"x" => nil}).x.should eq nil }
  end
end
