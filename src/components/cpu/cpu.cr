module CPU
  extend self # All functions appended to CPU.self.

  # Executes a single operation and returns result as array of integers. Pure function. No memory access or state changes allowed.
  def exec(opcode : Int, inputs : Array(Int)?, registers : Array(Int)) : Array(Int)?
    return nil
  end

  # Executes a single operation, with memory access and state changes returned.
  def exec_full(opcode : Int, inputs : Array(Int)?, registers : Array(Int)) : Tuple(String, Int)?
    return nil
  end

  # Run program, returning a chronological array of tuples containing memory accesses and state changes.
  def run(program : String) : Array(Tuple(String, Int))?
    return [] of Tuple(String, Int32)
  end


  # Raised when the given operation is not defined in OP_HASH.
  #
  # ```crystal
  # run_op(0x1234, nil, [] of Int32) # raises UnsupportedOpcodeException
  # ```
  class UnsupportedOpcodeException < Exception
    def initialize(message = "Given CPU opcode not supported/defined.")
      super(message)
    end
  end

  # Raised when CPU.run has a WASM call with wrong number of parameters.
  #
  # ```crystal
  # run(0x01, [0], [] of Int32) # raises IllegalNumberOfParametersException
  # ```
  class IllegalNumberOfParametersException < Exception
    def initialize(message = "Given program contains WASM call with wrong number of parameters.")
      super(message)
    end
  end
end
