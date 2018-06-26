module ALU

  # Raised when the given operation is not defined in OP_HASH.
  #
  # ```crystal
  # run_op(1, 2, 1236781) # raises UnsupportedOpcodeException
  # ```
  class UnsupportedOpcodeException < Exception
    def initialize(message = "Given ALU opcode not supported/defined.")
      super(message)
    end
  end

  OP_HASH = {
    0 => ->(a : UInt64, b : UInt64) { 0 },
    1 => ->(a : UInt64, b : UInt64) { A + B },
    2 => ->(a : UInt64, b : UInt64) { A - B },
  }

  # TODO: Full documentation
  # Run an operation on two operands (a, b).
  def run_op(a : UInt64, b : UInt64, opcode : UInt64)
    op = OP_HASH[opcode]
    raise UnsupportedOpcodeException.new if op.nil?
    return op.call(a, b)
  end

  def run_op_signed(a : Int64, b : Int64, opcode : UInt64)
    # TODO: Convert a and b to UInt64, call run_op, then convert result.
  end
end
