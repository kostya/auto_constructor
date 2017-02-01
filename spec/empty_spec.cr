require "./spec_helper"

struct Empty
  include AutoConstructor
end

describe AutoConstructor do
  it "work with empty struct" do
    empty = Empty.new
  end
end
