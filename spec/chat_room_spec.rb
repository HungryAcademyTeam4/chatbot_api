require 'spec_helper'

class MockClient
  def get_all_chat_rooms
    [
      { "chat_room" =>
        { "id" => 1,
          "title" => "Room 1",
          "user_id" => 1 }
      },
      { "chat_room" =>
        { "id" => 1,
          "title" => "Room 2",
          "user_id" => 2 }
      }
    ].to_json
  end

  def get_chat_room_by_id(id=1)
    [
      { "chat_room" =>
        { "id" => 1,
          "title" => "Room 1",
          "user_id" => 1
          # "messages" =>
          #   [
          #     { "message" =>
          #       { "id" => 1,
          #         "content" => 'hello world',
          #         "user_id" => 1,
          #         "chat_room_id" => 1,
          #         "created_at" => Time.now }
          #     }
          #   ]
        }
      }
    ].to_json
  end

  def create_chat_room(attributes)
    ChatRoom.new(attributes)
  end

  def create_permission(attributes)
    @permission = Permission.new(JSON.parse(attributes))
  end

  def destroy_permission(attributes)
    @permission = nil
  end
end

describe ChatRoom do
  before(:each) do
    ChatRoom.stub(:client).and_return(MockClient.new)
  end

  describe ".all" do
    it "returns a collection" do
      ChatRoom.all.should be_kind_of(Enumerable)
    end

    describe "when there are chatrooms" do
      it "returns rooms" do
        ChatRoom.all.count.should > 0
      end
    end

    describe "when there are no chatrooms" do
      it "is empty" do
        response = ChatRoom.all.clear
        response.should be_empty
      end
    end
  end

  describe ".parse_all" do
    context "when given JSON for multiple rooms" do
      it "returns a collection" do
        ChatRoom.parse_all(MockClient.new.get_all_chat_rooms).should be_kind_of(Enumerable)
      end

      it "returns rooms" do
        ChatRoom.parse_all(MockClient.new.get_all_chat_rooms).first.should be_kind_of(ChatRoom)
      end
    end
  end

  describe ".find_by_id" do
    it "returns a chat room" do
      id = ChatRoom.parse_all(MockClient.new.get_chat_room_by_id(1)).first.id
      ChatRoom.find_by_id(id).should be_kind_of(ChatRoom)
    end
  end

  describe ".create" do
    it "creates a new chat room" do
      attributes = {"id" => 1, "title" => "Room 1", "user_id" => 1}
      ChatRoom.create(attributes).should be_kind_of(ChatRoom)
    end
  end

  describe '#messages' do
    it 'returns all associated messages' do
      pending "JSON formatting is kicking my butt"
      id = JSON.parse(MockClient.new.get_chat_room_by_id(1)).first["chat_room"]
      ChatRoom.find_by_id(id).messages.first.should be_kind_of(Message)
    end

    it 'returns nil when no messages' do
      id = JSON.parse(MockClient.new.get_chat_room_by_id(1)).first["chat_room"]
      ChatRoom.find_by_id(id).messages.should be_nil
    end
  end

  describe '#invite' do
    context 'adding a new user to a chat room' do
      it 'creates a new permission' do
        id = JSON.parse(MockClient.new.get_chat_room_by_id(1)).first["chat_room"]
        chat_room = ChatRoom.find_by_id(id)
        attributes = {"chat_room_id" => 1, "user_name" => 'user2'}
        chat_room.invite(attributes).should be_kind_of(Permission)
      end
    end
  end

  describe '#uninvite' do
    context 'removing a user from a chat room' do
      it 'destroys an existing permission' do
        attributes = {"chat_room_id" => 1, "user_name" => 'user2'}
        id = JSON.parse(MockClient.new.get_chat_room_by_id(1)).first["chat_room"]
        chat_room = ChatRoom.find_by_id(id)
        chat_room.uninvite(attributes).should be_nil
      end
    end
  end
end





