require "../../spec_helper"

describe CPU do
  describe "execution handler" do
    describe ", WASM mode" do
      it "should execute all instructions" do
        # See: https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md#instructions
        CPU.exec(0x01, Nil, []) # opcode, tuple of inputs, register state
        # TODO
      end
      it "should run mnemonic assembly in text format" do
        program = <<-WASM
            nop
            (local $res i32)
            (set_local $res (i32.const 7))
            (if
              (i32.gt_s (
                i32.add((2) (3))
                (4)
              ))

              (set_local $res (
                i32.add((2) (3))
              ))
            )
            WASM
        CPU.run(program)
      end
    end
  end
end