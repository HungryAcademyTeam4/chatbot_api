require 'json'
require 'faraday'

module ChatbotApi
  class Client
    BASE_URL = "http://localhost:3000"

    def initialize
      @connection = Faraday.new(url: BASE_URL)
    end

    def get_all_chat_rooms
      response = @connection.get do |req|
        req.url "/api/v1/chat_rooms"
        req.headers['Content-Type'] = 'application/json'
      end
      response.body
    end

    def get_chat_room_by_id(id)
      response = @connection.get do |req|
        req.url "/api/v1/chat_rooms/#{id}"
        req.headers['Content-Type'] = 'application/json'
      end
      #need to return as an array
      parsed = JSON.parse(response.body)
      [parsed].to_json
    end

    def create_chat_room(attributes)
      @connection.post do |req|
        req.url "/api/v1/chat_rooms"
        req.headers['Content-Type'] = 'application/json'
        req.body = attributes
      end
    end

    def create_message(attributes)
      @connection.post do |req|
        req.url "/api/v1/messages"
        req.headers['Content-Type'] = 'application/json'
        req.body = attributes
      end
    end

    def create_permission(attributes)
      @connection.post do |req|
        req.url "/api/v1/permissions"
        req.headers['Content-Type'] = 'application/json'
        req.body = attributes
      end
    end

    def destroy_permission(attributes)
      id = JSON.parse(attributes)["chat_room_id"]
      @connection.delete do |req|
        req.url "/api/v1/permissions/#{id}"
        req.headers['Content-Type'] = 'application/json'
        req.body = attributes
      end
    end

    def get_all_messages
      response = @connection.get do |req|
        req.url "/api/v1/messages"
        req.headers['Content-Type'] = 'application/json'
      end
      response.body
    end

    def check_permission(user_name, id)
      @connection.get do |req|
        req.url "/api/v1/chat_rooms/#{id}"
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def get_message_by_id(id)
      response = @connection.get do |req|
        req.url "/api/v1/messages/#{id}"
        req.headers['Content-Type'] = 'application/json'
      end
      #need to return as an array
      parsed = JSON.parse(response.body)
      [parsed].to_json
    end

  end
end