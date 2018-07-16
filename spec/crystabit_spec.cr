require "./spec_helper"

describe Crystabit do
  it "finds all components" do
    CPU.should be_truthy
    ALU.should be_truthy
    Register.should be_truthy
  end
end
