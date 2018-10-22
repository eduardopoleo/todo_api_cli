require 'faraday'
require 'faraday_middleware'

#TODO: this should be top level that requires all the other scopes e.g users, lists etc.

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

    class Lists
      def self.create(name:)
        client.post do |req|
          req.url '/lists'
          req.body = { name: name }.to_json
          req.headers['Authorization'] = Keychain.generic_passwords.where(:service =>'todo-api').first&.password
        end
      end

      # ugly as fuck. Need to split this classes into different scopes 
      # and extrac this into a Faraday client module
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