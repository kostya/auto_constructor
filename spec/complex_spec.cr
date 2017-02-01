require "./spec_helper"

class ComplexSimple
  include AutoConstructor
  field x, Int32
end

class Complex
  include AutoConstructor
  field :x, Int32
  field :y, String, default: "def"
  field :z, Int32
  field :d, String?
  field :b, ComplexSimple, default: ComplexSimple.new(1)
end

describe AutoConstructor do
  context "complex" do
    it do
      s2 = Complex.new(x: 10, z: 11)
      s2.x.should eq 10
      s2.y.should eq "def"
      s2.z.should eq 11
      s2.d.should eq nil
      s2.b.x.should eq 1
    end

    it do
      s2 = Complex.new(x: 10, y: "bla", z: 11)
      s2.x.should eq 10
      s2.y.should eq "bla"
      s2.z.should eq 11
      s2.d.should eq nil
      s2.b.x.should eq 1
    end

    it do
      s2 = Complex.new(10, "bla", 11)
      s2.x.should eq 10
      s2.y.should eq "bla"
      s2.z.should eq 11
      s2.d.should eq nil
      s2.b.x.should eq 1
    end

    it do
      s2 = Complex.new({:x => 10, :z => 11})
      s2.x.should eq 10
      s2.y.should eq "def"
      s2.z.should eq 11
      s2.d.should eq nil
      s2.b.x.should eq 1
    end

    it do
      s2 = Complex.new({"x" => 10, "z" => 11, "d" => "bla"})
      s2.x.should eq 10
      s2.y.should eq "def"
      s2.z.should eq 11
      s2.d.should eq "bla"
      s2.b.x.should eq 1
    end
  end
end
