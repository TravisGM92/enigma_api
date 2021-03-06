# frozen_string_literal: true

module Api
  module V1
    class EncryptController < ApplicationController
      def find
        render json: EnigmaSerializer.format_response(Enigma.transform(params))
      end
    end
  end
end
