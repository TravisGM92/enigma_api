# frozen_string_literal: true

class TransformChars
  def self.all_characters
    alphabet = [*'a'..'z', *'A'..'Z']
    symbols = %w[! @ # $ % ^ & * ( ) ? , . : ;]
    [alphabet, symbols].flatten
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
    new_key = []
    key.chars.each.with_index do |number, index|
      new_key << "#{number}#{key.chars[index + 1]}" if index != key.length - 1
    end
    new_key
  end

  def self.offsets(data)
    key = format_key(data['key'])
    date = format_date(data['date'])
    offsets = []
    4.times do |i|
      offsets << date[i].to_i + key[i].to_i
    end
    offsets
  end

  def self.indexed_message_offset(data)
    new_indecies = []
    data[:indexed_message].length.times do |i|
      new_indecies << data[:indexed_message][i] + data[:offsets][i]
    end
    new_indecies
  end

  def self.indecies_to_chars(indecies)
    indecies.map { |index| all_characters[index % all_characters.length] }.join
  end

  def self.transform_message(data)
    indexed_message_offset({ indexed_message: chars_to_indecies(data['message']), offsets: offsets(data) })
  end
end
