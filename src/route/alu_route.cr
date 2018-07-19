require "kemal"
require "../components/alu/alu"

get "/v1/alu/exec" do |env|
  begin
    opcode = env.params.query["opcode"].to_i
    a = env.params.query["a"].to_i
    b = env.params.query["b"].to_i
    halt env, status_code: 200, response: ALU.run_op(opcode, a, b)
  rescue ex
    puts ex.message
    halt env, status_code: 500, response: Hash{"message" => ex.message}.to_json
  end
end

get "/v1/alu/run" do |env|
  begin
    res = [] of Int64
    query = env.params.query["q"]
    # TODO
    halt env, status_code: 200, response: "WIP"
  rescue ex
    puts ex.message
    halt env, status_code: 500, response: Hash{"message" => ex.message}.to_json
  end
end
