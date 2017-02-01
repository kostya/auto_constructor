require "./spec_helper"

struct WithNilableSimple
  include AutoConstructor
  field :a, Int32
end

struct WithNilable
  include AutoConstructor

  field :a, Int32
  field :b, String?
  field :d, Int32 | Nil
  field :c, WithNilableSimple
  field :e, Nil | Int32
end

context "with_nilable" do
  it do
    s1 = WithNilableSimple.new(1)
    s2 = WithNilable.new(10, "b", nil, s1, 10)
    s2.a.should eq 10
    s2.b.should eq "b"
    s2.c.should eq s1
    s2.d.should eq nil
    s2.e.should eq 10
  end

  it do
    s1 = WithNilableSimple.new(1)
    s2 = WithNilable.new(10, nil, nil, s1)
    s2.a.should eq 10
    s2.b.should eq nil
    s2.c.should eq s1
    s2.d.should eq nil
    s2.e.should eq nil
  end

  it do
    s1 = WithNilableSimple.new(1)
    s2 = WithNilable.new(c: s1, a: 10)
    s2.a.should eq 10
    s2.b.should eq nil
    s2.c.should eq s1
    s2.d.should eq nil
    s2.e.should eq nil
  end

  it do
    s1 = WithNilableSimple.new(1)
    s2 = WithNilable.new(c: s1, a: 10, d: 15)
    s2.a.should eq 10
    s2.b.should eq nil
    s2.c.should eq s1
    s2.d.should eq 15
    s2.e.should eq nil

    s2.e = 99
    s2.e.should eq 99
  end
end
