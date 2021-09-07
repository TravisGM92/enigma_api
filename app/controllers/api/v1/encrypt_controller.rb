module Api
  module V1
    class EncryptController < ApplicationController
      def find
        Enigma.encrypt(params)
      end
    end
  end
end
