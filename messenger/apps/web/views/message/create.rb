# frozen_string_literal: true

require 'openssl'

module Web
  module Views
    module Message
      class Create
        include Web::View
        def safelink
          'Your safe link: http://localhost:2300/message/' + params[:message][:safelink]
        end

        def password
          'Password to see message: ' + params[:message][:password]
        end

        def text_message
          Interactors::EncryptAndDecryptMessage.new.decrypt(params[:message][:text], params[:message][:iv])
        end
      end
    end
  end
end
