require "kemal"
require "../components/cpu/cpu"

get "/v1/cpu/exec" do |env|
  env.response.content_type = "application/json"

  begin
    opcode = env.params.query["opcode"]?.try &.to_i || 0x01
    inputs = env.params.query["inputs"]?.try &.to_i || [] of Int64
    globals = env.params.query["globals"]?.try &.to_i || [] of Int64

    Hash{
      "ret" => CPU.exec(opcode, inputs, globals)
    }.to_json
  rescue ex
    puts ex.message
    halt env, status_code: 500, response: Hash{"message" => ex.message}.to_json
  end
end
