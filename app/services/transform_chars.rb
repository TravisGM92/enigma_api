# frozen_string_literal: true

class TransformChars
  def self.all_characters
    alphabet = [*'a'..'z', *'A'..'Z']
    symbols = %w[! @ # $ % ^ & * ( ) ? , . : ;]
    [alphabet, symbols, ' '].flatten
  end

  def self.chars_to_indecies(data)
    data.chars.map do |character|
      all_characters.index(character)
    end
  end

  def self.format_date(date)
    date_squared = date.to_i**2
    date_squared.to_s[-4..-1]
  end

  def self.format_key(key)
    key.chars.map.with_index do |number, index|
      "#{number}#{key.chars[index + 1]}" if index != key.length - 1
    end.compact
  end

  def self.offsets(data)
    key = format_key(data['key'])
    date = format_date(data['date'])
    key.map.with_index do |_element, index|
      date[index].to_i + key[index].to_i
    end
  end

  def self.indexed_message_offset(data)
    data[:indexed_message].map.with_index do |_element, index|
      if data[:status]
        data[:indexed_message][index] - data[:offsets][index % 4]
      else
        data[:indexed_message][index] + data[:offsets][index % 4]
      end
    end
  end

  def self.indecies_to_chars(indecies)
    indecies.map { |index| all_characters[index % all_characters.length] }.join
  end

  def self.transform_message(data)
    engima_data = {
      indexed_message: chars_to_indecies(data['message']),
      offsets: offsets(data),
      status: data['status']
    }
    indexed_message_offset(engima_data)
  end
end
