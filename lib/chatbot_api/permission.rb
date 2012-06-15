class Permission
  attr_accessor :user_id, :chat_room_id

  def initialize(attributes)
    self.user_id    = attributes["user_id"]
    self.chat_room_id = attributes["chat_room_id"]
  end
end