# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enigma, type: :model do
  describe 'method' do
    before(:each) do
      @data = {
        'date' => '090821',
        'key' => '01101',
        'message' => 'app'
      }
    end
    it '#transform(), encrypt' do
      encrypted = Enigma.transform(@data)
      expect(encrypted).to be_a Hash
      expect(encrypted.keys).to eq(%i[encrypted_message date key status])
      expect(encrypted[:encrypted_message]).to eq('fAD')
    end

    it '#format_encryption()' do
      data = {
        indecies: [0, 10, 2, 5],
        date: '090821',
        key: '23415'
      }
      encrypted = Enigma.format_encryption(data)
      expect(encrypted).to be_a Hash
      expect(encrypted.keys).to eq(%i[encrypted_message date key status])
      expect(encrypted[:encrypted_message]).to eq('akcf')
      expect(encrypted[:status]).to eq('encrypted')
    end

    it '#format_decryption()' do
      data = {
        indecies: [0, 10, 2, 5],
        date: '090821',
        key: '23415'
      }
      encrypted = Enigma.format_decryption(data)
      expect(encrypted).to be_a Hash
      expect(encrypted.keys).to eq(%i[decrypted_message date key status])
      expect(encrypted[:decrypted_message]).to eq('akcf')
      expect(encrypted[:status]).to eq('decrypted')
    end
  end
end

RSpec.describe Enigma, type: :model do
  describe 'method' do
    before(:each) do
      @data = {
        'date' => '090821',
        'key' => '01101'
      }
    end
    it '#transform() can encrypt a word with 10 characters' do
      @data['message'] = 'yUtIopmnhD'
      encrypted = Enigma.transform(@data)
      expect(encrypted).to be_a Hash
      expect(encrypted[:encrypted_message].length).to eq(10)
    end

    it '#transform() can encrypt a message with spaces between letters & words' do
      @data['message'] = 'hey there'
      encrypted = Enigma.transform(@data)
      expect(encrypted[:encrypted_message].length).to eq(9)
    end
  end
end

RSpec.describe Enigma, type: :model do
  describe 'method' do
    it '#transform(), decrypt' do
      data = {
        'date' => '090821',
        'key' => '01101',
        'message' => 'hey'
      }
      encrypted = Enigma.transform(data)
      decrypted = Enigma.transform({
                                     'message' => encrypted[:encrypted_message],
                                     'date' => encrypted[:date],
                                     'key' => encrypted[:key],
                                     'status' => 'decrypt'
                                   })
      expect(decrypted[:key]).to eq(data['key'])
      expect(decrypted[:date]).to eq(data['date'])
      expect(decrypted[:decrypted_message]).to eq(data['message'])
    end
  end
end
