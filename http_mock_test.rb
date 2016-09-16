require "net/http"
require "uri"
require "json"
require "base64"
require "yaml"

module TwitterBearerTokens
  def TwitterBearerTokens.getBearerToken(options)
    consumer_key = options[:conkey]
    consumer_secret = options[:consec]

    uri = URI("https://api.twitter.com/oauth2/token")
    data = "grant_type=client_credentials"
    cre   = Base64.strict_encode64("#{consumer_key}:#{consumer_secret}")
    authorization_headers = { "Authorization" => "Basic #{cre}"}
    bearer_token = nil

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      response = http.request_post(uri, data, authorization_headers)
      token_hash = JSON.parse(response.body)
      bearer_token = token_hash["access_token"]
    end

    bearer_token
  end
end
