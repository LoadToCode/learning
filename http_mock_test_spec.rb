require "./http_mock_test"
require "mocha"
require "net/http"

describe TwitterBearerTokens do
  it "doesn't make a real http request" do
    http = mock :http
    Net::HTTP.stub!(:start).and_yield http
    http.should_receive(:request_post).and_return "iamasecretbeartoken"

    token = TwitterBearerTokens.getBearerToken(:consec => "abc", :conkey => "def")

    expect(token).to eq "iamasecretbeartoken"
  end
end
