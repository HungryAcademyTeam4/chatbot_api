require 'json'
require 'faraday'

module ChatbotApi
  class Client
    BASE_URL = "http://localhost:3000"

    def initialize
      @connection = Faraday.new(url: BASE_URL)
    end

    def get_all_chat_rooms
      @connection.get do |req|
        req.url "/api/v1/chat_rooms"
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def get_chat_room_by_id(id)
      @connection.get do |req|
        req.url "/api/v1/chat_rooms/#{id}"
        req.headers['Content-Type'] = 'application/json'
      end
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
  end
end