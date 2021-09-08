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
    status_update(data, response)
  end

  def self.status_update(data, response)
    data[:status] == 'encrypted' ? result = :encrypted_message : result = :decrypted_message
    response[:data][result] = data[result]
    response
  end
end
