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
      response.body
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

    def get_all_messages
      response = @connection.get do |req|
        req.url "/api/v1/messages"
        req.headers['Content-Type'] = 'application/json'
      end
      response.body
    end

    def get_message_by_id(id)
      response = @connection.get do |req|
        req.url "/api/v1/messages/#{id}"
        req.headers['Content-Type'] = 'application/json'
      end
      response.body
    end

  end
end