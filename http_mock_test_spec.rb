require "./http_mock_test"
require 'webmock/rspec'

describe TwitterBearerTokens do
  it do
    stub_request(:post, "https://api.twitter.com/oauth2/token").
         with(:body => "grant_type=client_credentials",
              :headers => {'Authorization'=>"Basic #{Base64.strict_encode64("AAA:BBB")}"}).
         to_return(:status => 200, :body => JSON.dump(access_token: 'this is the new token'))

    result = TwitterBearerTokens.getBearerToken(conkey: 'AAA', consec: 'BBB')

    expect(result).to eq('this is the new token')
  end

  it do
    stub_request(:post, "https://api.twitter.com/oauth2/token").
         with(:body => "grant_type=client_credentials",
              :headers => {'Authorization'=>"Basic #{Base64.strict_encode64("AAA:BBB")}"}).
         to_return(:status => 500)

    expect { TwitterBearerTokens.getBearerToken(conkey: 'AAA', consec: 'BBB') }.to raise_error('There was a problem with the Twitter server')
  end
end
