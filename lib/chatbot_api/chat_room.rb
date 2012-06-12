require 'json'

class ChatRoom
  attr_accessor :title, :user_id, :id, :created_at

  def self.client
    ChatbotApi::Client.new
  end

  def initialize(attributes)
    self.id         = attributes["id"]
    self.title      = attributes["title"]
    self.user_id    = attributes["user_id"]
    self.created_at = attributes["created_at"]
    self.user_name  = attributes["user_name"]
  end

  def self.all
    parse_all(client.get_all_chat_rooms)
  end

  def self.find_by_id(id)
    parse_all(client.get_chat_room_by_id(id)).first
  end

  def self.create(attributes)
    client.create_chat_room(attributes.to_json)
  end

  def self.parse_all(json_package)
    JSON.parse(json_package).collect do |room_attributes|
      ChatRoom.new(room_attributes["chat_room"])
    end
  end

  def messages
    response = ChatRoom.client.get_chat_room_by_id(self.id)
    parsed = JSON.parse(response)
    raw_messages = parsed.first["chat_room"]["messages"]
    if raw_messages.nil?
      return nil
    else
      messages = raw_messages.collect do |msg_attributes|
      Message.new(msg_attributes["message"])
    end
  end
end
