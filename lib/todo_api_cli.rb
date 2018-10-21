require 'faraday'
require 'faraday_middleware'

module TodoApi
  API_URL='http://localhost:9393'

  class Cli
    class Users
      def self.create(name:, email:, password:)
        client.post do |req|
          req.url '/users'
          req.body = { name: name, email: email, password: password }.to_json
        end
      end

      def self.login(email:, password:)
        client.post do |req|
          req.url '/login'
          req.body = { email: email, password: password }.to_json
        end
      end

      def self.client
        @@conn ||= Faraday.new(url: TodoApi::API_URL) do |f|
          f.request  :url_encoded         
          f.adapter  Faraday.default_adapter
          f.request  :url_encoded
          f.request  :json
          f.response :json, content_type: /\bjson$/
        end
      end
    end
  end
end