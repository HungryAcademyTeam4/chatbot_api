require 'json'

class ChatRoom
  attr_accessor :title, :user_id, :id, :created_at, :user_name, :locked

  def self.client
    ChatbotApi::Client.new
  end


  def initialize(attributes)
    self.id         = attributes["id"]
    self.title      = attributes["title"]
    self.user_id    = attributes["user_id"]
    self.created_at = attributes["created_at"]
    self.user_name  = attributes["user_name"]
    self.locked     = attributes["locked"]
  end

  def self.all(user_id)
    parse_all(client.get_all_chat_rooms(user_id))
  end

  def self.find_by_id(attributes)
    parse_all(client.get_chat_room_by_id(attributes)).first
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
    response = ChatRoom.client.get_chat_room_by_id({id: self.id})
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

  def invite(attributes) #pass user_id, chat_room_id
    ChatRoom.client.create_permission(attributes.to_json)
  end

  def uninvite(attributes) #pass user_id, chat_room_id
    ChatRoom.client.destroy_permission(attributes.to_json)
  end

  def permits?(attributes) #pass user_id, chat_room_id
    response = ChatRoom.client.check_permission(attributes)
    parsed = JSON.parse(response)
    #returning key 'chat_room' means the response came through, otherwise key is 'error'
    true if parsed.keys.include?("chat_room")
  end
end
