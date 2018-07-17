module CPU
  extend self # All functions appended to CPU.self.

  # TODO: Workaround for compiler type inference regression; use ->(a : Int, b : Int) once it is available.
  {% begin %}
    {% int = "Int8 | Int16 | Int32 | Int64 | Int128 | UInt8 | UInt16 | UInt32 | UInt64 | UInt128" %}
    {% int = int.id %}

    # Executes a single operation and returns result as Int?. Pure function. No outside access or state changes allowed.
    def exec(opcode : {{int}}, inputs : Array({{int}} | Symbol)?, registers : Array({{int}})) : {{int}} | Nil
      return nil
    end

    # Executes a single operation, with memory access and state changes returned. CPU.exec result is in `ret` value.
    def exec_full(opcode : {{int}}, inputs : Array({{int}} | Symbol)?, registers : Array({{int}})) : Hash(String, {{int}} | Nil)
      return {} of (String, {{int}})
    end

    # Run program, returning a chronological array of hashes containing memory accesses and state changes.
    def run(program : String) : Array(Hash(String, {{int}}))
      return [] of Hash(String, {{int}})
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
  {% end %}
end
