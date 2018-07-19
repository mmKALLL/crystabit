require "../../spec_helper"


describe ALU do
  describe "operation handler" do

    describe "opcode 0 (return zero)" do
      it "should return 0 regardless of values" do
        ALU.run_op(0, 0, 1).should eq 0
        ALU.run_op(0, 0, 0).should eq 0
        ALU.run_op(0, 123, 456).should eq 0
        ALU.run_op(0, 2, 7).should eq 0
        ALU.run_op(0, -2, 5).should eq 0
      end
      it "should handle all integer types" do
        ALU.run_op(0, 2_i8, 7_i8).should eq 0
        ALU.run_op(0, 32760_i16, 7_i16).should eq 32767
        ALU.run_op(0, 2_147_483_640_i32, 7_i32).should eq 2_147_483_647
        ALU.run_op(0, 2_i64, 7_i64).should eq 0
        ALU.run_op(0, 2_i128, 7_i128).should eq 0
        ALU.run_op(0, 2_u8, 7_u8).should eq 0
        ALU.run_op(0, 2_u16, 7_u16).should eq 0
        ALU.run_op(0, 2_u32, 7_u32).should eq 0
        ALU.run_op(0, 2_u64, 7_u64).should eq 0
        ALU.run_op(0, 2_u128, 7_u128).should eq 0
      end
    end

    describe "opcode 1 (sum)" do
      it "should sum two values" do
        ALU.run_op(1, 0, 0).should eq 0
        ALU.run_op(1, 0, 1).should eq 1
        ALU.run_op(1, 123, 456).should eq 579
        ALU.run_op(1, 2, 7).should eq 9
      end
      it "should sum negative values" do
        ALU.run_op(1, -2, 5).should eq 3
        ALU.run_op(1, -0, -2).should eq -2
        ALU.run_op(1, -52345, -2147289329).should eq (-52345 + -2147289329)
        ALU.run_op(1, -2147403648, 1147483648).should eq (-2147403648 + 1147483648)
      end
      it "should handle all integer types" do
        ALU.run_op(1, 2_i8, 7_i8).should eq 9_i8
        ALU.run_op(1, 32760_i16, 7_i16).should eq 32767_i16
        ALU.run_op(1, 2_147_483_640_i32, 7_i32).should eq 2_147_483_647_i32
        ALU.run_op(1, 2_i64, 7_i64).should eq 9
        ALU.run_op(1, 2_i128, 7_i128).should eq 9
        # EXTEND: Long i128 literals not yet supported by parser.
        # ALU.run_op(1, 17_000_000_000__000_000_000__000_000_000__000_000_000_i128, 7_i128).should eq 17_000_000_000__000_000_000__000_000_000__000_000_007_i128
        ALU.run_op(1, 2_u8, 7_u8).should eq 9_u8
        ALU.run_op(1, 2_u16, 7_u16).should eq 9
        ALU.run_op(1, 2_u32, 7_u32).should eq 9
        ALU.run_op(1, 2_u64, 7_u64).should eq 9
        ALU.run_op(1, 2_u128, 7_u128).should eq 9
      end
      it "should handle sum overflow as in crystal" do
        # TODO
      end
    end

    describe "opcode 2 (substract)" do
      it "should substract two UInt64 values" do
        ALU.run_op(2, 1, 0).should eq 1
        ALU.run_op(2, 20, 15).should eq 5
        ALU.run_op(2, 9_u64, 7_u64).should eq 2
      end
      it "should handle negative values and underflow as in crystal" do
        ALU.run_op(2, -52345, -2147289329).should eq (-52345 - -2147289329)
        ALU.run_op(2, -2147403648, 1147483648).should eq (-2147403648 - 1147483648)
      end
    end

    describe "opcode 3 (bitwise AND)" do
      it "should AND two UInt64 values" do
        ALU.run_op(3, 1, 0).should eq 0
        ALU.run_op(3, 20, 15).should eq 15
        ALU.run_op(3, 2, 7).should eq 2
        ALU.run_op(3, 1237841_u64, 51746284_u64).should eq (1237841_u64 & 51746284_u64)
      end
      it "should AND negative values as in crystal" do
        ALU.run_op(3, -52345, -2147289329).should eq (-52345 & -2147289329)
        ALU.run_op(3, -2147403648, -1147483648).should eq (-2147403648 & -1147483648)
      end
    end

    describe "opcode 4 (bitwise OR)" do
      it "should OR two UInt64 values" do
        ALU.run_op(4, 1, 0).should eq 1
        ALU.run_op(4, 20, 15).should eq 31
        ALU.run_op(4, 2, 7).should eq 7
        ALU.run_op(4, 1237841_u64, 51746284_u64).should eq (1237841_u64 | 51746284_u64)
      end
      it "should OR negative values as in crystal" do
        ALU.run_op(4, -52345, -2147289329).should eq (-52345 | -2147289329)
        ALU.run_op(4, -2147403648, -1147483648).should eq (-2147403648 | -1147483648)
      end
    end

    describe "opcode 5 (bitwise XOR)" do
      it "should XOR two UInt64 values" do
        ALU.run_op(5, 1, 0).should eq 1
        ALU.run_op(5, 20, 15).should eq 16
        ALU.run_op(5, 2, 7).should eq 0
        ALU.run_op(5, 1237841_u64, 51746284_u64).should eq (1237841_u64 ^ 51746284_u64)
      end
      it "should XOR negative values as in crystal" do
        ALU.run_op(5, -52345, -2147289329).should eq (-52345 ^ -2147289329)
        ALU.run_op(5, -2147403648, -1147483648).should eq (-2147403648 ^ -1147483648)
      end
    end

    describe "opcode 6 (complement NOT)" do
      it "should NOT an UInt64 value, disregarding second input" do
        ALU.run_op(4, 1, 0).should eq -1
        ALU.run_op(4, 20, 15).should eq -20
        ALU.run_op(4, 2, 7).should eq -2
        ALU.run_op(4, 1237841_u64, 51746284_u64).should eq -1237841_u64
      end
      it "should NOT negative UInt64 values as in crystal" do
        ALU.run_op(4, -52345, -2147289329).should eq ~-52345
        ALU.run_op(4, -2147483648, -1147483648).should eq 2147403648
      end
    end

    it "should raise UnsupportedOpcodeException on unknown opcode" do
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(12347898, 2, 7)
      end
    end

    it "should raise UnsupportedOpcodeException on too large opcode" do
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(127_i8 + 1_i8, 2, 7)
      end
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(255_u8, 2, 7)
      end
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(2147483648, 2, 7)
      end
    end

    it "should raise UnsupportedOpcodeException on negative opcode" do
      expect_raises ALU::UnsupportedOpcodeException do
        ALU.run_op(-1, 2, 7)
      end
    end

    it "should handle mixed integer types as in crystal" do
      # TODO
    end

    it "should handle operations with random values" do
      r = Random.new
      {% for i in (1..1000) %}
        # TODO: Iterate through list of operators
        op_1_{{i.id}} = r.rand(Int64::MIN..Int64::MAX)
        op_2_{{i.id}} = r.rand(Int64::MIN..Int64::MAX)
        ALU.run_op(0x01).should eq (op_1_{{i.id}} + op_2_{{i.id}}, op_1_{{i.id}}, op_2_{{i.id}})
        ALU.run_op(0x02).should eq (op_1_{{i.id}} - op_2_{{i.id}}, op_1_{{i.id}}, op_2_{{i.id}})
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
