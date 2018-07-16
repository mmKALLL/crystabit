module CPU
  extend self # All functions appended to CPU.self.

  # Executes a single operation and returns result as array of integers. Pure function. No memory access or state changes allowed.
  def exec(opcode : Int, inputs : Array of Int, registers : Array of Int) : Array? of Int64 {
    return Nil
  }

  # Executes a single operation, with memory access and state changes returned
  def exec_full()

  # Run program, returning an array of memory accesses and state changes.
  def run(program : String) : Array? of Int64 {
    return [] of Int32
  }

end
