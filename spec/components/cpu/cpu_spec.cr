require "../../spec_helper"

describe CPU do
  describe "execution handler" do
    describe ", WASM mode" do
      it "should execute all instructions" do
        # See: https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md#instructions
        # opcode, array of inputs, register state
        CPU.exec(0x01, Nil, [] of Int64).should eq Nil
        # TODO
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
        CPU.run(program).should eq
        [
            {locals.res, Nil},
            {locals.res, 7_i32},
            {locals.res, 5_i32}
        ]
      end
    end
  end
end
