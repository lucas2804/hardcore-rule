require "httparty"
token = "a06eeb3e1d4d2f8639c192e33c11b319"
url = "http://localhost:3000/api/v1/tests.json"
response = HTTParty.get(url, headers: {"Authorization" => "Token token=#{token}"})

puts response.parsed_response