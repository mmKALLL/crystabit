require "../spec_helper"

describe ALU do
  describe "operation handler" do

    describe "opcode 0 (return zero)" do
      # TODO
    end

    describe "opcode 1 (sum)" do
      it "should sum two UInt64 values" do
        ALU.run_op(0, 1, 1).should eq 1
        ALU.run_op(123, 456, 1).should eq 579
        ALU.run_op(2, 7, 1).should eq 9
      end
      it "should handle overflow (as in crystal??? or raise error? or using run_op overload?)" do
        # TODO
      end
    end

    describe "opcode 2 (substract)" do
      it "should substract two UInt64 values" do
        ALU.run_op(1, 0, 2).should eq 1
        ALU.run_op(20, 15, 2).should eq 5
        ALU.run_op(2, 7, 2).should eq -5 # FIXME: undefined for UInt64
      end
    end

    it "should raise (some exception???) on negative input of UInt params" do
      # TODO
    end

    it "should raise UnsupportedOpcodeException on unknown opcode" do
      expect_raises ALU.UnsupportedOpcodeException do
        ALU.run_op(2, 7, 12347898)
      end
    end

    it "should raise UnsupportedOpcodeException on too large opcode" do
      expect_raises ALU.UnsupportedOpcodeException do
        ALU.run_op(2, 7, 128_i8)
      end
      expect_raises ALU.UnsupportedOpcodeException do
        ALU.run_op(2, 7, 256_u8)
      end
      expect_raises ALU.UnsupportedOpcodeException do
        ALU.run_op(2, 7, 2147483648)
      end
    end

    it "should raise UnsupportedOpcodeException on negative opcode" do
      expect_raises ALU.UnsupportedOpcodeException do
        ALU.run_op(2, 7, -1)
      end
    end

    describe "type overload macro" do
      it "should work on all unsigned integer sizes" do
        # TODO
      end
      it "should work on all signed integer sizes" do

      end
    end

  end
end
