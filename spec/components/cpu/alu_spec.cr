require "../../spec_helper"


describe ALU do
  describe "operation handler" do

    describe "opcode 0 (return zero)" do
      it "should return 0 regardless of values" do
        ALU.run_op(0, 1, 0).should eq 0
        ALU.run_op(0, 0, 0).should eq 0
        ALU.run_op(123, 456, 0).should eq 0
        ALU.run_op(2, 7, 0).should eq 0
        ALU.run_op(-2, 5, 0).should eq 0
      end
      it "should handle all integer types" do
        ALU.run_op(2_i8, 7_i8, 0).should eq 0
        ALU.run_op(32760_i16, 7_i16, 0).should eq 32767
        ALU.run_op(2_147_483_640_i32, 7_i32, 0).should eq 2_147_483_647
        ALU.run_op(2_i64, 7_i64, 0).should eq 0
        ALU.run_op(2_i128, 7_i128, 0).should eq 0
        ALU.run_op(2_u8, 7_u8, 0).should eq 0
        ALU.run_op(2_u16, 7_u16, 0).should eq 0
        ALU.run_op(2_u32, 7_u32, 0).should eq 0
        ALU.run_op(2_u64, 7_u64, 0).should eq 0
        ALU.run_op(2_u128, 7_u128, 0).should eq 0
      end
    end

    describe "opcode 1 (sum)" do
      it "should sum two values" do
        ALU.run_op(0, 0, 1).should eq 0
        ALU.run_op(0, 1, 1).should eq 1
        ALU.run_op(123, 456, 1).should eq 579
        ALU.run_op(2, 7, 1).should eq 9
      end
      it "should sum negative values" do
        ALU.run_op(-2, 5, 1).should eq 3
        ALU.run_op(-0, 0, 1).should eq -0
      end
      it "should handle all integer types" do
        ALU.run_op(2_i8, 7_i8, 1).should eq 9_i8
        ALU.run_op(32760_i16, 7_i16, 1).should eq 32767_i16
        ALU.run_op(2_147_483_640_i32, 7_i32, 1).should eq 2_147_483_647_i32
        ALU.run_op(2_i64, 7_i64, 1).should eq 9
        ALU.run_op(2_i128, 7_i128, 1).should eq 9
        # TODO: Long i128 literals not yet supported by parser.
        # ALU.run_op(17_000_000_000__000_000_000__000_000_000__000_000_000_i128, 7_i128, 1).should eq 17_000_000_000__000_000_000__000_000_000__000_000_007_i128
        ALU.run_op(2_u8, 7_u8, 1).should eq 9_u8
        ALU.run_op(2_u16, 7_u16, 1).should eq 9
        ALU.run_op(2_u32, 7_u32, 1).should eq 9
        ALU.run_op(2_u64, 7_u64, 1).should eq 9
        ALU.run_op(2_u128, 7_u128, 1).should eq 9
      end
      it "should handle sum overflow as in crystal" do
        # TODO
      end
    end

    describe "opcode 2 (substract)" do
      it "should substract two UInt64 values" do
        ALU.run_op(1, 0, 2).should eq 1
        ALU.run_op(20, 15, 2).should eq 5
        ALU.run_op(2, 7, 2).should eq -5 # FIXME: undefined for UInt64
      end
      it "should handle all integer types" do
        # TODO
      end
      it "should handle negative values and underflow as in crystal" do
        # TODO
      end
    end

    it "should raise UnsupportedOpcodeException on unknown opcode" do
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(2, 7, 12347898)
      end
    end

    it "should raise UnsupportedOpcodeException on too large opcode" do
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(2, 7, 127_i8 + 1_i8)
      end
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(2, 7, 255_u8)
      end
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(2, 7, 2147483648)
      end
    end

    it "should raise UnsupportedOpcodeException on negative opcode" do
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(2, 7, -1)
      end
    end

    it "should handle mixed integer types as in crystal" do
      # TODO
    end

    it "should handle operations with random values" do
      r = Random.new
      {% for i in (1..1000) %}
        op_1_{{i.id}} = r.rand(Int64::MIN..Int64::MAX)
        op_2_{{i.id}} = r.rand(Int64::MIN..Int64::MAX)
        ALU.run_op(op_1_{{i.id}}, op_2_{{i.id}}, 0x01).should eq (op_1_{{i.id}} + op_2_{{i.id}})
        ALU.run_op(op_1_{{i.id}}, op_2_{{i.id}}, 0x02).should eq (op_1_{{i.id}} - op_2_{{i.id}})
      {% end %}
    end

  end

  describe "safe operation handler" do
    it "should run operations normally if parameter size/width/sign match" do

    end
    it "should return nil if parameters are not the same type" do
      ALU.run_op_safe(31234_u32, 127_i8, 1).should eq nil
      ALU.run_op_safe(31_i8, 31235_u32, 3).should eq nil
      ALU.run_op_safe(31, 31235, 3_i8).should eq nil
    end
  end
end
