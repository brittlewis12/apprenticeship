require "spec_helper"
require_relative "../lib/change_machine"

describe "#make_change" do
  it "takes a number of cents as a argument" do
    expect{make_change}.to raise_error ArgumentError
  end

  it "returns a currency set" do
    expect(make_change(10)).to be_an_instance_of Array
  end

  it "makes change correctly with least number of coins" do
    expect(make_change(1)).to eq [0, 0, 0, 1]
    expect(make_change(5)).to eq [0, 0, 1, 0]
    expect(make_change(10)).to eq [0, 1, 0, 0]
    expect(make_change(25)).to eq [1, 0, 0, 0]
    expect(make_change(31)).to eq [1, 0, 1, 1]
  end

  it "makes change up to 100 cents" do
    expect(make_change(101)).to eq("Please enter a number of cents below 100.")
  end
end

describe "#count_change" do
  it "takes a currency set" do
    expect{count_change}.to raise_error ArgumentError
  end

  it "returns a number of cents" do
    expect(count_change({pennies: 6, dimes: 3, quarters: 1, nickels: 3})).to be_an Integer
  end

  it "counts change correctly" do
    expect(count_change({pennies: 6, dimes: 3, quarters: 1, nickels: 3})).to eq 76
  end
end
