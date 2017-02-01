require "./spec_helper"

class Nilable1
  include AutoConstructor
  field :x, Int32?, default: 1
end

class Nilable2
  include AutoConstructor
  field :x, Int32?, default: nil
end

class Nilable3
  include AutoConstructor
  field :x, Bool?, default: false
end

class Nilable4
  include AutoConstructor
  field :x, Bool?, default: true
end

class Nilable5
  include AutoConstructor
  field :x, Bool?, default: nil
end

describe AutoConstructor do
  context "Nilable1" do
    it { Nilable1.new(2).x.should eq 2 }
    it { Nilable1.new.x.should eq 1 }
    it { Nilable1.new(nil).x.should eq nil }

    it { Nilable1.new(x: 2).x.should eq 2 }
    it { Nilable1.new(x: nil).x.should eq nil }
    it { Nilable1.new(y: nil).x.should eq 1 }

    it { Nilable1.new({:x => 2}).x.should eq 2 }
    it { Nilable1.new({:x => nil}).x.should eq nil }
    it { Nilable1.new({:y => nil}).x.should eq 1 }

    it { Nilable1.new({"x" => 2}).x.should eq 2 }
    it { Nilable1.new({"x" => nil}).x.should eq nil }
    it { Nilable1.new({"y" => nil}).x.should eq 1 }
  end

  context "Nilable2" do
    it { Nilable2.new(2).x.should eq 2 }
    it { Nilable2.new.x.should eq nil }
    it { Nilable2.new(nil).x.should eq nil }

    it { Nilable2.new(x: 2).x.should eq 2 }
    it { Nilable2.new(x: nil).x.should eq nil }
    it { Nilable2.new(y: nil).x.should eq nil }

    it { Nilable2.new({:x => 2}).x.should eq 2 }
    it { Nilable2.new({:x => nil}).x.should eq nil }
    it { Nilable2.new({:y => nil}).x.should eq nil }

    it { Nilable2.new({"x" => 2}).x.should eq 2 }
    it { Nilable2.new({"x" => nil}).x.should eq nil }
    it { Nilable2.new({"y" => 1}).x.should eq nil }
  end

  context "Nilable3" do
    it { Nilable3.new(true).x.should eq true }
    it { Nilable3.new(false).x.should eq false }
    it { Nilable3.new.x.should eq false }
    it { Nilable3.new(nil).x.should eq nil }

    it { Nilable3.new(x: true).x.should eq true }
    it { Nilable3.new(x: false).x.should eq false }
    it { Nilable3.new(x: nil).x.should eq nil }
    it { Nilable3.new(y: nil).x.should eq false }

    it { Nilable3.new({:x => true}).x.should eq true }
    it { Nilable3.new({:x => false}).x.should eq false }
    it { Nilable3.new({:x => nil}).x.should eq nil }
    it { Nilable3.new({:y => nil}).x.should eq false }

    it { Nilable3.new({"x" => true}).x.should eq true }
    it { Nilable3.new({"x" => false}).x.should eq false }
    it { Nilable3.new({"x" => nil}).x.should eq nil }
    it { Nilable3.new({"y" => 1}).x.should eq false }
  end

  context "Nilable4" do
    it { Nilable4.new(true).x.should eq true }
    it { Nilable4.new(false).x.should eq false }
    it { Nilable4.new.x.should eq true }
    it { Nilable4.new(nil).x.should eq nil }

    it { Nilable4.new(x: true).x.should eq true }
    it { Nilable4.new(x: false).x.should eq false }
    it { Nilable4.new(x: nil).x.should eq nil }
    it { Nilable4.new(y: nil).x.should eq true }

    it { Nilable4.new({:x => true}).x.should eq true }
    it { Nilable4.new({:x => false}).x.should eq false }
    it { Nilable4.new({:x => nil}).x.should eq nil }
    it { Nilable4.new({:y => nil}).x.should eq true }

    it { Nilable4.new({"x" => true}).x.should eq true }
    it { Nilable4.new({"x" => false}).x.should eq false }
    it { Nilable4.new({"x" => nil}).x.should eq nil }
    it { Nilable4.new({"y" => 1}).x.should eq true }
  end

  context "Nilable5" do
    it { Nilable5.new(true).x.should eq true }
    it { Nilable5.new(false).x.should eq false }
    it { Nilable5.new.x.should eq nil }
    it { Nilable5.new(nil).x.should eq nil }

    it { Nilable5.new(x: true).x.should eq true }
    it { Nilable5.new(x: false).x.should eq false }
    it { Nilable5.new(x: nil).x.should eq nil }
    it { Nilable5.new(y: nil).x.should eq nil }

    it { Nilable5.new({:x => true}).x.should eq true }
    it { Nilable5.new({:x => false}).x.should eq false }
    it { Nilable5.new({:x => nil}).x.should eq nil }
    it { Nilable5.new({:y => nil}).x.should eq nil }

    it { Nilable5.new({"x" => true}).x.should eq true }
    it { Nilable5.new({"x" => false}).x.should eq false }
    it { Nilable5.new({"x" => nil}).x.should eq nil }
    it { Nilable5.new({"y" => 1}).x.should eq nil }
  end
end
