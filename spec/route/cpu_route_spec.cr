require "../spec_helper.cr"

describe "CPU API endpoint" do
  it "should return 404 if unspecified URI is given" do
    get "/v1/undefined"
    response.status_code.should eq 404
  end

  it "should return 200 if ..." do
    get "/v1/cpu/exec", headers: {}, body: {}
    response.status_code.should eq 200
    response.body.should eq "{}"
    # TODO
  end
end
