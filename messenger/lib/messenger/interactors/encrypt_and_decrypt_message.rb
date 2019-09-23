# frozen_string_literal: true

require 'hanami/interactor'
require 'openssl'

module Interactors
  class EncryptAndDecryptMessage
    include Hanami::Interactor

    attr_accessor :message_text_encrypt, :message_text_decrypt

    KEY = 'ThisPasswordIsReallyHardToGuess!'

    def encrypt(message_text_encrypt)
      cipher = OpenSSL::Cipher::AES256.new :CBC
      cipher.encrypt
      @iv = cipher.random_iv
      message_text_encrypt[:iv] = @iv
      cipher.key = KEY
      @cipher_text = cipher.update(message_text_encrypt[:text]) + cipher.final
    end

    def decrypt(message_text_decrypt, i_v)
      decipher = OpenSSL::Cipher::AES256.new :CBC
      decipher.decrypt
      decipher.iv = i_v
      decipher.key = KEY
      decipher.update(message_text_decrypt) + decipher.final
    end
  end
end
