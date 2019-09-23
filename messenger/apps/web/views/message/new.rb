# frozen_string_literal: true

module Web
  module Views
    module Message
      class New
        include Web::View

        def generate_safe_link
          @message = SecureRandom.urlsafe_base64(8)
        end
      end
    end
  end
end
