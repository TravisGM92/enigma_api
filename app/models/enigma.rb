class Enigma < ApplicationRecord
  def self.encrypt(data)
    indexed_message = TransformChars.chars_to_indecies(data['message'])
    formatted_date = TransformChars.format_date(data['date'])
    formatted_key = TransformChars.format_key(data['key'])
    offsets = TransformChars.offsets({date_squared: formatted_date, key: formatted_key})
    encrypted_indecies = TransformChars.indexed_message_offset({indexed_message: indexed_message, offsets: offsets})
    encrypted_message = TransformChars.indecies_to_chars(encrypted_indecies)
  end
end
