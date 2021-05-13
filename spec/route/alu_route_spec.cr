require "../spec_helper.cr"

describe "ALU API endpoint" do
  it "should return 404 if unspecified URI is given" do
    get "/v1/undefined"
    response.status_code.should eq 404
  end

  describe "should return 200 when" do
    describe "running valid operations," do
      describe "params in query," do
        # Run a single op.
        it "exec" do
          get "/v1/alu/exec?opcode=0x01&a=2&b=7", headers: HTTP::Headers{"x-user" => "testuser"}
          response.status_code.should eq 200
          response.body.should eq "9"
          get "/v1/cpu/exec?opcode=3&a=13&b=20", headers: HTTP::Headers{"x-user" => "testuser"}
          response.status_code.should eq 200
          response.body.should eq "4"
        end

        # Run multiple operations, given as array of [opcode, a, b] triplets
        it "run" do
          get "/v1/alu/run?q=[[0x01,2,7], [3,13,20]]", headers: HTTP::Headers{"x-user" => "testuser"}
          response.status_code.should eq 200
          response.body.should eq "9,4"
        end
      end
    end
  end

  # TODO: Malformed requests and basic pentest
end
