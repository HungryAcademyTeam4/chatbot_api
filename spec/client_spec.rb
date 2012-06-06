require 'rspec'
require 'faraday'
require './lib/chatbot_api/client'

describe ChatbotApi::Client do
  let(:client) { ChatbotApi::Client.new }
  APPROVED = (200..299)
  DECLINED = (400..599)

  describe "#get_all_chat_rooms" do
    it "returns all the chat rooms" do
      response = client.get_all_chat_rooms
      APPROVED.should include response.status
    end
  end

  describe "#get_chat_room_by_id" do
    it "returns a specific chat room" do
      response = client.get_chat_room_by_id(1)
      APPROVED.should include response.status
    end
  end

  describe "#create_chat_room" do
    it "creates a new chat room" do
      response = client.create_chat_room('{"title":"michael", "user_id":1}')
      APPROVED.should include response.status
    end

    it "fails to create a new chat room" do
      response = client.create_chat_room('{}')
      DECLINED.should include response.status
    end
  end

  describe "#create_message" do
    it "creates a new message" do
      response = client.create_message('{"content":"test", "user_id":1, "chat_room_id":1 }')
      APPROVED.should include response.status
    end

    it "fails to create a new message" do
      response = client.create_message('{}')
      DECLINED.should include response.status
    end
  end
end