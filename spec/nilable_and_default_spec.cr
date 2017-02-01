require "./spec_helper"

class NilableAndDefault
  include AutoConstructor
  field :x, Int32?, default: 1
end

class NilableAndDefaultBool
  include AutoConstructor
  field :x, Bool?, default: false
  field :y, Bool?, default: true

  def xy
    {x, y}
  end
end

describe AutoConstructor do
  context "NilableAndDefault" do
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

  context "NilableAndDefaultBool" do
    it { NilableAndDefaultBool.new(true, true).xy.should eq({true, true}) }
    it { NilableAndDefaultBool.new(true, false).xy.should eq({true, false}) }
    it { NilableAndDefaultBool.new(false, true).xy.should eq({false, true}) }
    it { NilableAndDefaultBool.new(false, false).xy.should eq({false, false}) }

    it { NilableAndDefaultBool.new(x: true, y: true).xy.should eq({true, true}) }
    it { NilableAndDefaultBool.new(x: true, y: false).xy.should eq({true, false}) }
    it { NilableAndDefaultBool.new(x: false, y: true).xy.should eq({false, true}) }
    it { NilableAndDefaultBool.new(x: false, y: false).xy.should eq({false, false}) }

    it { NilableAndDefaultBool.new(x: true).xy.should eq({true, true}) }
    it { NilableAndDefaultBool.new(x: false).xy.should eq({false, true}) }

    it { NilableAndDefaultBool.new(y: true).xy.should eq({false, true}) }
    it { NilableAndDefaultBool.new(y: false).xy.should eq({false, false}) }

    it { NilableAndDefaultBool.new(x: nil).xy.should eq({nil, true}) }
    it { NilableAndDefaultBool.new(y: nil).xy.should eq({false, nil}) }
    it { NilableAndDefaultBool.new(x: nil, y: nil).xy.should eq({nil, nil}) }
    it { NilableAndDefaultBool.new(nil, nil).xy.should eq({nil, nil}) }
  end
end
