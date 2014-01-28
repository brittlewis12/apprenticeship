require "spec_helper"
require_relative "../lib/change_machine"

describe ChangeMachine do
  let!(:cm){ChangeMachine.new(currency_set: [25, 10, 5, 1])}

  describe "#make_change" do
    it "takes a number of cents as a argument" do
      expect{cm.make_change}.to raise_error ArgumentError
    end

    it "returns a currency set" do
      expect(cm.make_change(10)).to be_an_instance_of Array
    end

    it "makes change correctly with least number of coins" do
      expect(cm.make_change(1)).to eq [0, 0, 0, 1]
      expect(cm.make_change(5)).to eq [0, 0, 1, 0]
      expect(cm.make_change(10)).to eq [0, 1, 0, 0]
      expect(cm.make_change(25)).to eq [1, 0, 0, 0]
      expect(cm.make_change(31)).to eq [1, 0, 1, 1]
    end

    it "makes change up to 100 cents" do
      expect{cm.make_change(101)}.to raise_error ArgumentError, "Argument must be less than 100"
    end
  end

  describe "#count_change" do
    it "takes a currency set" do
      expect{cm.count_change}.to raise_error ArgumentError
    end

    it "returns total number of cents" do
      expect(cm.count_change(quarters: 1, dimes: 3, nickels: 3, pennies: 6)).to be_an Integer
    end

    it "takes does not depend on argument order" do
      expect(cm.count_change(pennies: 6, dimes: 3, quarters: 1, nickels: 3)).to eq 76
    end

    it "counts change correctly" do
      expect(cm.count_change(pennies: 6, dimes: 3, quarters: 1, nickels: 3)).to eq 76
      expect(cm.count_change(quarters: 2, nickels: 0, pennies: 3, dimes: 1)).to eq 63
    end

    it "handles when a particular coin is not specified, defaulting to 0" do
      expect(cm.count_change(quarters: 3, pennies: 4)).to eq 79
    end
  end
end
