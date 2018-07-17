require "../../spec_helper"

describe CPU do
  describe "execution handler" do
    describe ", HLE multi-input mode" do
      # TODO
    end

    describe ", WASM mode" do
      describe "should execute all instructions, with correct number of params expected," do
        # See: https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md#instructions
        # opcode, array of inputs, register state

        it "0x01: nop" do
          CPU.exec(0x01, [] of Int64, [] of Int64).should eq nil
          expect_raises CPU::IllegalNumberOfParametersException do
            CPU.exec(0x01, [3, 87123], [1, 2, 3, 12387])
          end
        end

        it "0x1a: drop" do
          expect_raises CPU::IllegalNumberOfParametersException do
            CPU.exec(0x1a, [] of Int64, [] of Int64)
            CPU.exec(0x1a, [3, 87123, 213], [1, 2, 3, 12387])
          end
          CPU.exec(0x1a, [3], [1, 2, 3, 12387]).should eq nil
          CPU.exec(0x1a, [12343112313123_u64], [1, 2, 3, 12387]).should eq nil

          # TODO: Also test exec_full
        end

        it "0x21: set_local, 0x20: get_local" do
          CPU.exec_full(0x21, [:test, 15], [] of Int64).should eq nil
          CPU.exec_full(0x21, [:test2, 112344312], [] of Int64).should eq nil
          CPU.exec_full(0x21, [123, 12], [1, 2, 3, 23412] of Int64).should eq nil

          CPU.exec_full(0x20, [:test], [] of Int64).should eq 15
          CPU.exec_full(0x20, [:test2], [] of Int64).should eq 112344312
          CPU.exec_full(0x21, [123], [] of Int64).should eq 12

          # Sequence of gets and sets on same address
          CPU.exec_full(0x20, [:test], [] of Int64).should eq 15
          CPU.exec_full(0x21, [:test, 1], [] of Int64).should eq nil
          CPU.exec_full(0x20, [:test], [] of Int64).should eq 1
          CPU.exec_full(0x21, [:test, 2], [] of Int64).should eq nil
          CPU.exec_full(0x20, [:test], [] of Int64).should eq 2

          CPU.exec_full(0x20, [321], [] of Int64).should eq nil
          CPU.exec_full(0x21, [321, 3], [] of Int64).should eq nil
          CPU.exec_full(0x20, [321], [] of Int64).should eq 3
          CPU.exec_full(0x21, [321, 4], [] of Int64).should eq nil
          CPU.exec_full(0x20, [321], [] of Int64).should eq 4

          # TODO: what should exec do here?
        end

        it "0x7c: i64.add" do
          CPU.exec(0x7c, [2, 7], [] of Int32).should eq 9
          CPU.exec(0x7c, [2_i64, 7_i64], [] of Int64).should eq 9
          CPU.exec_full(0x7c, [2, 7], [] of Int32).should eq Hash{"ret" => 9}
          CPU.exec_full(0x7c, [2_i64, 7_i64], [] of Int64).should eq Hash{"ret" => 9}
          CPU.exec_full(0x7c, [2, 7], [1, 2, 3] of Int64).should eq Hash{"ret" => 9}
        end
      end

      it "should run mnemonic assembly in text format" do
        program = <<-WASM
            nop
            (local $res i32)
            (set_local $res (i32.const 7))
            (if
              (
                i32.gt_s
                  (i32.add((2) (3)))
                  (i32.const 4)
              )

              (set_local $res (
                i32.add((2) (3))
              ))
            )
            WASM
        CPU.run(program).should eq \
        [
            {"locals.res", 0_i32}, # FIXME: Default value for `(local $res i32)` unspecified, check WASM spec for `local` mnemonic.
            {"locals.res", 7_i32},
            {"locals.res", 5_i32}
        ]
      end

      it "should raise UnsupportedOpcodeException on too large opcode" do
        expect_raises CPU::UnsupportedOpcodeException do
          CPU.exec(0x12314123, [] of Int32, [] of Int32)
        end
        expect_raises CPU::UnsupportedOpcodeException do
          CPU.exec(0x100, [123, 2] of Int32, [1, 2, 3] of Int32)
        end
      end

      it "should raise UnsupportedOpcodeException on negative opcode" do
        expect_raises CPU::UnsupportedOpcodeException do
          CPU.exec(-1, [] of Int32, [] of Int32)
        end
      end
    end
  end
end
