require 'json'

class Message
  attr_accessor :content, :user_id, :id, :chat_room_id, :created_at, :user_name

  def self.client
    ChatbotApi::Client.new
  end

  def initialize(attributes)
    self.id           = attributes["id"]
    self.content      = attributes["content"]
    self.user_id      = attributes["user_id"]
    self.chat_room_id = attributes["chat_room_id"]
    self.created_at   = attributes["created_at"]
    self.user_name    = attributes["user_name"]
  end

  def self.all
    parse_all(client.get_all_messages)
  end

  def self.create(attributes)
    client.create_message(attributes.to_json)
  end

  def self.find_by_id(id)
    parse_all(client.get_message_by_id(id)).first
  end

  def self.parse_all(json_package)
    JSON.parse(json_package).collect do |message_attributes|
      Message.new(message_attributes["message"])
    end
  end

end