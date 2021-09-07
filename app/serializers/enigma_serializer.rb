# frozen_string_literal: true

class EnigmaSerializer
  def self.format_response(data)
    response = {
      data: {
        key: data[:key],
        date: data[:date]
      },
      id: nil,
      type: 'enigma'
    }
    if data[:status] == 'encrypted'
      response[:data][:encrypted_message] =
        data[:encrypted_message]
    else
      response[:data][:decrypted_message] =
        data[:decrypted_message]
    end
    response
  end
end
