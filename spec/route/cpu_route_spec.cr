require "../spec_helper.cr"

describe "CPU API endpoint" do
  it "should return 404 if unspecified URI is given" do
    get "/v1/undefined"
    response.status_code.should eq 404
  end

  describe "should return 200 on executing valid operation," do
    describe "params in body," do
      it "0x01: nop" do
        get "/v1/cpu/exec", headers: HTTP::Headers{"x-user" => "testuser"}, body: {
          opcode => 0x01,
          inputs => [] of Int64,
          registers => [] of Int64,
        }.to_json
        response.status_code.should eq 200
        response.body.should eq "{}"
      end
      it "0x7c: i64.add" do
        get "/v1/cpu/exec", headers: HTTP::Headers{"x-user" => "testuser"}, body: {
          opcode => 0x7c,
          inputs => [2, 7] of Int64,
          registers => [] of Int64,
        }.to_json
        response.status_code.should eq 200
        response.body.should eq "{\"ret\": 9}"
      end
    end
  end

  # TODO: Malformed requests and infosec concerns
end
