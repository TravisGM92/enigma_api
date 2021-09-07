# frozen_string_literal: true

class Enigma < ApplicationRecord
  def self.encrypt(data)
    encrypted_indecies = TransformChars.transform_message(data)
    {
      encrypted_message: TransformChars.indecies_to_chars(encrypted_indecies),
      date: data['date'],
      key: data['key'],
      status: 'encrypted'
    }
  end
end
