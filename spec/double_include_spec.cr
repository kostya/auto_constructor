require "./spec_helper"

module Bla
  include AutoConstructor
end

class DoubleInclude1
  include Bla
  field :x, Int32
end

class DoubleInclude2 < DoubleInclude1
  field :y, String

  def xy
    {x, y}
  end
end

module Bla2
  include AutoConstructor
end

module Bla3
  include Bla2
  field :x, Int32

  macro finished
    def bla
      s = ""
      \{% for field in AUTO_CONSTRUCTOR_FIELDS %}
        s += \{{ field[:name].id.stringify }}
      \{% end %}
      s
    end
  end
end

class DoubleInclude3
  include Bla3
  field :y, String

  def xy
    {x, y}
  end
end

class DoubleInclude4 < DoubleInclude3
  field :z, String

  def xyz
    {x, y, z}
  end
end

class DoubleInclude5 < DoubleInclude4
  field :d, Int32

  def xyzd
    {x, y, z, d}
  end
end

describe AutoConstructor do
  it { DoubleInclude1.new(1).x.should eq 1 }
  it { DoubleInclude1.new(x: 1).x.should eq 1 }

  it { DoubleInclude2.new(1, "2").xy.should eq({1, "2"}) }
  it { DoubleInclude2.new(y: "2", x: 1).xy.should eq({1, "2"}) }

  it { DoubleInclude3.new(1, "2").xy.should eq({1, "2"}) }
  it { DoubleInclude3.new(y: "2", x: 1).xy.should eq({1, "2"}) }
  it { DoubleInclude3.new(y: "2", x: 1).bla.should eq "xy" }

  it { DoubleInclude4.new(1, "2", "z").xyz.should eq({1, "2", "z"}) }
  it { DoubleInclude4.new(y: "2", x: 1, z: "z").xyz.should eq({1, "2", "z"}) }
  it { DoubleInclude4.new(y: "2", x: 1, z: "z").bla.should eq "xyz" }

  it { DoubleInclude5.new(1, "2", "z", 2).xyzd.should eq({1, "2", "z", 2}) }
  it { DoubleInclude5.new(1, "2", "z", 2).bla.should eq "xyzd" }
end
