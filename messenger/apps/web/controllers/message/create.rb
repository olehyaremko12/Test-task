# frozen_string_literal: true

require 'pry'

module Web
  module Controllers
    module Message
      class Create
        include Web::Action

        def call(params)
          repository = MessageRepository.new
          params[:message][:text] = Interactors::EncryptAndDecryptMessage.new.encrypt(params[:message])
          repository.create(params[:message])
        end
      end
    end
  end
end
