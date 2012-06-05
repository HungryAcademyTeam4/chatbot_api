require 'json'
require 'faraday'

module ChatbotApi
  class Client

    def initialize
      @connection = Faraday.new(url: "http://localhost:3000/api/v1")
    end

    def get_all_chat_rooms
      response = @connection.get('/chat_rooms')
    end

    def get_chat_room_by_id(id)
      response = @connection.get("/chat_rooms/#{id}")
    end

    def create_chat_room(attributes)
      @connection.post do |req|
        req.url '/chat_rooms'
        req.headers['Content-Type'] = 'application/json'
        req.body = '{ "title": "hasdfasdf" }'
      end
    end
  end
end