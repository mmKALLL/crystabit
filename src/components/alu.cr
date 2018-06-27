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

  # TODO: Workaround for compiler regression; use ->(a : Int, b : Int) once it is available.
  {% begin %}
    {% int = "Int8 | Int16 | Int32 | Int64 | Int128 | UInt8 | UInt16 | UInt32 | UInt64 | UInt128" %}
    {% int = int.id %}

    OP_HASH = {
      0 => ->(a : {{int}}, b : {{int}}) { 0 },
      1 => ->(a : {{int}}, b : {{int}}) { a + b },
      2 => ->(a : {{int}}, b : {{int}}) { a - b },
    }
  {% end %}

  # TODO: Full documentation
  # Run an operation on two integer operands (a, b). Parameters should be the same type.
  def run_op(a : Int, b : Int, opcode : Int) : Int
    op = OP_HASH[opcode]
    raise UnsupportedOpcodeException.new if op.nil?
    return op.call(a, b)
  end

  # TODO: handle FPU functionality too?
end
