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
    1 => ->(A : UInt64, B : UInt64) { A + B },
    2 => ->(A : UInt64, B : UInt64) { A - B },
  }

  # TODO: Full documentation
  # Run an operation on two operands (A, B).
  def run_op(A: UInt64, B: UInt64, opcode: UInt64) {
    op = OP_HASH[opcode]
    raise UnsupportedOpcodeException if op.nil?
    return op.call(A, B)
  }

  def run_op_signed(A: Int64, B: Int64, opcode: UInt64) {
    # TODO: Convert A and B to UInt64, call run_op, then convert result.
  }
