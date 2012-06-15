class Permission
  attr_accessor :user_name, :chat_room_id

  def initialize(attributes)
    self.user_name    = attributes["user_name"]
    self.chat_room_id = attributes["chat_room_id"]
  end
end