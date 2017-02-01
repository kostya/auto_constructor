require "./spec_helper"

struct MoreFieldsSimple
  include AutoConstructor
  field :a, Int32
end

struct MoreFields
  include AutoConstructor

  field :a, Int32
  field :b, String
  field :c, MoreFieldsSimple
end

describe AutoConstructor do
  context "more_field" do
    it do
      s1 = MoreFieldsSimple.new(1)
      s2 = MoreFields.new(10, "b", s1)
      s2.a.should eq 10
      s2.b.should eq "b"
      s2.c.should eq s1
    end

    it do
      s1 = MoreFieldsSimple.new(1)
      s2 = MoreFields.new(a: 10, b: "b", c: s1)
      s2.a.should eq 10
      s2.b.should eq "b"
      s2.c.should eq s1
    end

    it do
      s1 = MoreFieldsSimple.new(1)
      s2 = MoreFields.new(c: s1, b: "b", a: 10)
      s2.a.should eq 10
      s2.b.should eq "b"
      s2.c.should eq s1
    end
  end
end
