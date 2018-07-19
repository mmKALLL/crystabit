require "../spec_helper.cr"

describe "CPU API endpoint" do
  it "should return 404 if unspecified URI is given" do
    get "/v1/undefined"
    response.status_code.should eq 404
  end

  describe "should return 200 when" do
    describe "running valid WASM in text format," do
      it "simple if-else" do

      end
    end

    describe "executing valid operation," do
      describe "params in body," do
        it "0x01: nop" do
          get "/v1/cpu/exec", headers: HTTP::Headers{"x-user" => "testuser"}, body: Hash{
            "opcode" => 0x01,
            "inputs" => [] of Int64,
            "registers" => [] of Int64,
          }.to_json
          response.status_code.should eq 200
          response.body.should eq "{}"
        end

        it "0x7c: i64.add" do
          get "/v1/cpu/exec", headers: HTTP::Headers{"x-user" => "testuser"}, body: Hash{
            "opcode" => 0x7c,
            "inputs" => [2_i64, 7_i64],
            "registers" => [] of Int64,
          }.to_json
          response.status_code.should eq 200
          response.body.should eq "{\"ret\":9}"
          get "/v1/cpu/exec", headers: HTTP::Headers{"x-user" => "testuser"}, body: Hash{
            "opcode" => 0x7c,
            "inputs" => [1234, 4321],
            "registers" => [1, 2, 3, 4],
          }.to_json
          response.status_code.should eq 200
          response.body.should eq "{\"ret\":5555}"
        end
      end

      describe "params in query," do
        it "0x7c: i64.add" do
          get "/v1/cpu/exec?opcode=0x7c&inputs=[2,7]&registers=[]", headers: HTTP::Headers{"x-user" => "testuser"}
          response.status_code.should eq 200
          response.body.should eq "{\"ret\":9}"
          get "/v1/cpu/exec?opcode=0x7c&inputs=[1234,4321]&registers=[1,2,3,4]", headers: HTTP::Headers{"x-user" => "testuser"}
          response.status_code.should eq 200
          response.body.should eq "{\"ret\":5555}"
        end
      end
    end
  end


  # TODO: Malformed requests and basic pentest
end
