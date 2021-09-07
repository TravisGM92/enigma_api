# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Encrypt' do
  it 'can encrypt a word with a key and date' do
    word = 'hey'
    key = '08349'
    date = '090321'

    post "/api/v1/encrypt?message=#{word}&date=#{date}&key=#{key}"
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    message = json[:data][:encrypted_message]
    expect(message).to be_a String
    expect(message.length).to eq(3)
    expect(message).to_not eq(word)
  end
end
