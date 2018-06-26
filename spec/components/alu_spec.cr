describe "ALU" do
  describe "operation handler" do
    describe "opcode 0 (return zero)" do

    end
    describe "opcode 1 (sum)" do
      it "should sum two UInt64 values" do
        ALU::run_op(0, 1, 1)
      end
      it "should handle overflow as in crystal" do
        # TODO
      end
    end
    describe "opcode 2 (substract)" do
      it "should substract two UInt64 values" do
        ALU::run_op(0, 1, 1)
      end
    end

    it "should raise UnsupportedOpcodeException on unknown opcode" do
      expect_raises ALU::UnsupportedOpcodeException do
        ALU::run_op(0, 1, 12347898)
      end
    end
  end
end
