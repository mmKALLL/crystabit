module ALU
  extend self # All functions appended to ALU.self.

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
    0 => ->(a : Int, b : Int) { 0 },
    1 => ->(a : Int, b : Int) { a + b },
    2 => ->(a : Int, b : Int) { a - b },
  }

  # TODO: Full documentation
  # Run an operation on two {{int}} operands (a, b). Parameters should be the same type.
  def run_op(a : Int, b : Int, opcode : Int) : Int forall Int
    op = OP_HASH[opcode]
    raise UnsupportedOpcodeException.new if op.nil?
    return op.call(a, b)
  end
end
