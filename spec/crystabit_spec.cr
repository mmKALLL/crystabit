require "./spec_helper"

describe Crystabit do
  it "finds all components" do
    ALU.should be_truthy
    Register.should be_truthy
  end
end
