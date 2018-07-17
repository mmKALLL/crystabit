require "kemal"
require "../components/cpu/cpu"

get "/v1/cpu/exec" do |env|
  env.response.content_type = "application/json"

  begin
    opcode = env.params.query["opcode"] || 0x01
    inputs = env.params.query["inputs"] || [] of Int64
    registers = env.params.query["registers"] || [] of Int64

    Hash{
      "ret" => CPU.exec(opcode, inputs, registers)
    }.to_json
  rescue ex
    puts ex.message
    halt env, status_code: 500, response: Hash{"message" => ex.message}.to_json
  end
end
