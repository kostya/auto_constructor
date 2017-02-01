require "./spec_helper"

struct WithDefaultsSimple
  include AutoConstructor
  field :a, Int32
end

struct WithDefaults
  include AutoConstructor

  field :a, Int32, default: 11
  field :b, String, default: "def"
  field :c, WithDefaultsSimple
end

context "with_defaults" do
  it do
    s1 = WithDefaultsSimple.new(1)
    s2 = WithDefaults.new(10, "b", s1)
    s2.a.should eq 10
    s2.b.should eq "b"
    s2.c.should eq s1
  end

  it do
    s1 = WithDefaultsSimple.new(1)
    s2 = WithDefaults.new(a: 10, b: "b", c: s1)
    s2.a.should eq 10
    s2.b.should eq "b"
    s2.c.should eq s1
  end

  it do
    s1 = WithDefaultsSimple.new(1)
    s2 = WithDefaults.new(c: s1)
    s2.a.should eq 11
    s2.b.should eq "def"
    s2.c.should eq s1
  end

  it do
    s1 = WithDefaultsSimple.new(1)
    s2 = WithDefaults.new(c: s1, a: 12)
    s2.a.should eq 12
    s2.b.should eq "def"
    s2.c.should eq s1
  end

  it do
    s1 = WithDefaultsSimple.new(1)
    s2 = WithDefaults.new(c: s1, b: "bla")
    s2.a.should eq 11
    s2.b.should eq "bla"
    s2.c.should eq s1
  end
end
