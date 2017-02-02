require "./spec_helper"

class AutoInherit1
  include AutoConstructor
  field :x, Int32
end

class AutoInherit2 < AutoInherit1
  field :y, String

  def xy
    {x, y}
  end
end

class AutoInherit3 < AutoInherit2
  field :z, String

  def xyz
    {x, y, z}
  end
end

class AutoInherit31 < AutoInherit2
  field :z, Int32

  def xyz
    {x, y, z}
  end
end

class AutoInherit32 < AutoInherit2
  field :zz, String

  def xyz
    {x, y, zz}
  end
end

class AutoInherit4 < AutoInherit3
  field :d, Int32

  def xyzd
    {x, y, z, d}
  end
end

describe AutoConstructor do
  it { AutoInherit1.new(1).x.should eq 1 }
  it { AutoInherit1.new(x: 1).x.should eq 1 }

  it { AutoInherit2.new(1, "2").xy.should eq({1, "2"}) }
  it { AutoInherit2.new(y: "2", x: 1).xy.should eq({1, "2"}) }

  it { AutoInherit3.new(1, "2", "z").xyz.should eq({1, "2", "z"}) }
  it { AutoInherit3.new(y: "2", x: 1, z: "z").xyz.should eq({1, "2", "z"}) }

  it { AutoInherit31.new(1, "2", 3).xyz.should eq({1, "2", 3}) }
  it { AutoInherit31.new(y: "2", x: 1, z: 3).xyz.should eq({1, "2", 3}) }

  it { AutoInherit32.new(1, "2", "z").xyz.should eq({1, "2", "z"}) }
  it { AutoInherit32.new(y: "2", x: 1, zz: "z").xyz.should eq({1, "2", "z"}) }

  it { AutoInherit4.new(1, "2", "z", 2).xyzd.should eq({1, "2", "z", 2}) }
  it { AutoInherit4.new(y: "2", x: 1, z: "z", d: 2).xyzd.should eq({1, "2", "z", 2}) }
end
