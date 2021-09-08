# frozen_string_literal: true

class Enigma < ApplicationRecord
  def self.transform(data)
    indecies = TransformChars.transform_message(data)
    if data['status'] == 'decrypt'
      format_decryption({ indecies: indecies, date: data['date'], key: data['key'] })
    else
      format_encryption({ indecies: indecies, date: data['date'], key: data['key'] })
    end
  end

  def self.format_encryption(data)
    {
      encrypted_message: TransformChars.indecies_to_chars(data[:indecies]),
      date: data[:date],
      key: data[:key],
      status: 'encrypted'
    }
  end

  def self.format_decryption(data)
    {
      decrypted_message: TransformChars.indecies_to_chars(data[:indecies]),
      date: data[:date],
      key: data[:key],
      status: 'decrypted'
    }
  end
end
