require "../spec_helper"

describe "ALU" do
  describe "operation handler" do

    describe "opcode 0 (return zero)" do
      # TODO
    end

    describe "opcode 1 (sum)" do
      it "should sum two UInt64 values" do
        ALU.run_op(0, 1, 1).should eq 1
        ALU.run_op(123, 456, 1).should eq 579
        ALU.run_op(0, 1, 1).should eq 1
      end
      it "should handle overflow (as in crystal??? or raise error? or using run_op overload?)" do
        # TODO
      end
    end

    describe "opcode 2 (substract)" do
      it "should substract two UInt64 values" do
        ALU.run_op(0, 1, 1)
      end
    end

    it "should raise (some exception???) on negative input" do
      # TODO
    end

    it "should raise UnsupportedOpcodeException on unknown opcode" do
      expect_raises ALU.UnsupportedOpcodeException do
        ALU.run_op(0, 1, 12347898)
      end
      expect_raises ALU.UnsupportedOpcodeException do
        ALU.run_op(0, 1, -1)
      end
    end

  end
end
