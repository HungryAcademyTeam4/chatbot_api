require 'spec_helper'

class MockClient
  def get_all_messages
    [
      {"message" =>
        {"id"           => 1,
         "content"      => "Chat 1",
         "user_id"      => 1,
         "chat_room_id" => 1}
      },
      {"message" =>
        {"id"           => 1,
         "content"      => "Chat 2",
         "user_id"      => 2,
         "chat_room_id" => 2}
      }
    ].to_json
  end

  def get_message_by_id(id=1)
    [
      {"message" =>
        {"id"           => 1,
         "content"      => "Chat 1",
         "user_id"      => 1,
         "chat_room_id" => 1}
      }
    ].to_json
  end

  def create_message(attributes)
    Message.new(attributes)
  end
end

describe Message do
  before(:each) do
    Message.stub(:client).and_return(MockClient.new)
  end

  describe ".all" do
    it "returns a collection" do
      Message.all.should be_kind_of(Enumerable)
    end

    describe "when there are messages" do
      it "returns messages" do
        Message.all.count.should > 0
      end
    end

    describe "when there are no messages" do
      it "is empty" do
        response = Message.all.clear
        response.should be_empty
      end
    end
  end

  describe ".parse_all" do
    context "when given JSON for multiple messages" do
      it "returns a collection" do
        Message.parse_all(MockClient.new.get_all_messages).should be_kind_of(Enumerable)
      end

      it "returns messages" do
        Message.parse_all(MockClient.new.get_all_messages).first.should be_kind_of(Message)
      end
    end
  end

  describe ".find_by_id" do
    it "returns a message" do
      id = Message.parse_all(MockClient.new.get_message_by_id(1)).first.id
      Message.find_by_id(id).should be_kind_of(Message)
    end
  end

  describe ".create" do
    it "creates a new message" do
      attributes = { "id"           => 1,
                     "content"      => "Chat 1",
                     "user_id"      => 1,
                     "chat_room_id" => 1 }
      Message.create(attributes).should be_kind_of(Message)
    end
  end
end