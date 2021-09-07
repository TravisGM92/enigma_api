# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TransformChars' do
  describe 'method' do
    it '#all_characters' do
      alphabet = [*'a'..'z', *'A'..'Z']
      all_chars = %w[! @ # $ % ^ & * ( ) ? , . : ;] + alphabet
      all_chars.each do |character|
        expect(TransformChars.all_characters.include?(character)).to be_truthy
      end
    end

    it '#chars_to_indecies()' do
      word = 'Nope'
      expect(TransformChars.chars_to_indecies(word)).to eq([39, 14, 15, 4])
      expect(TransformChars.chars_to_indecies("#{word}!")).to eq([39, 14, 15, 4, 52])
    end

    it '#format_date()' do
      date = '090721'
      expect(TransformChars.format_date(date)).to eq('9841')
    end

    it '#format_key()' do
      key = '097765'

      expect(TransformChars.format_key(key)).to eq(%w[09 97 77 76 65])
    end

    it '#offsets()' do
      date_squared = '9841'
      key = %w[09 97 77 76]
      data = {
        date_squared: date_squared,
        key: key
      }
      expect(TransformChars.offsets(data)).to eq([18, 105, 81, 77])
    end

    it '#indexed_message_offset()' do
      data = {
        indexed_message: [5, 10, 9],
        offsets: [2, 20, 9, 10]
      }
      expect(TransformChars.indexed_message_offset(data)).to eq([7, 30, 18])
    end

    it '#indecies_to_chars()' do
      expect(TransformChars.indecies_to_chars([5, 2, 60, 5])).to eq('fc(f')
    end
  end
end
