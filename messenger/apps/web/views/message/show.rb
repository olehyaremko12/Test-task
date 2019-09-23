# frozen_string_literal: true

module Web
  module Views
    module Message
      class Show
        include Web::View

        def text
          @repository = MessageRepository.new.all.map(&:to_h)
          @message = @repository.find { |x| x[:safelink] == params.get(:safelink) }

          if @message
            destroy_after_1_hour_method
            destroy_after_hours_method
            destroy_after_1_visit_method
          end
          @text_message || 'Wrong url'
        end

        def safe_link
          params.get(safelink)
        end

        def password
          @message[:password] if @message
        end

        private

        def delete_hours
          @message[:created_at] + (3600 * @message[:destroy_after_hours])
        end

        def delete_hour
          @message[:created_at] + 3600
        end

        def decrypt_method
          @text_message = Interactors::EncryptAndDecryptMessage.new.decrypt(@message[:text], @message[:iv])
        end

        def destroy_after_1_visit_method
          return unless @message[:destroy_after_1_visit] == 1

          @text_message = Interactors::DeleteMessage.new.destroy_after_1_visit(params.get(:safelink))
        end

        def destroy_after_hours_method
          if @message[:destroy_after_hours] > 1 && delete_hours > Time.now
            decrypt_method
          elsif @message[:destroy_after_hours] > 1 && delete_hours < Time.now
            Interactors::DeleteMessage.new.destroy_after_hours
            @text_message = false
          end
        end

        def destroy_after_1_hour_method
          if @message[:destroy_after_1_hour] == 1 && delete_hour > Time.now
            decrypt_method
          elsif @message[:destroy_after_1_hour] == 1 && delete_hour < Time.now
            Interactors::DeleteMessage.new.destroy_after_1_hour
            @text_message = false
          end
        end
      end
    end
  end
end
