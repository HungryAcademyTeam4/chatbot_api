require 'rspec'
gem 'faraday'

describe Client do
  let(:client) { ChatbotApi::Client.new }

  describe "#get_all_chat_rooms" do
    pending
    # response = client.stub(:get_all_chat_rooms).and_return({ title: "happy" }.to_json)
    # response.should == "{\"title\":\"happy\"}"

  end

  describe "#get_chat_room_by_id" do
    pending
    # response = client.get_chat_room_by_id(1)
  end
end