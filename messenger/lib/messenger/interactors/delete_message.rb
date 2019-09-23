# frozen_string_literal: true

require 'hanami/interactor'

module Interactors
  class DeleteMessage
    include Hanami::Interactor

    def initialize(repository: MessageRepository.new.all.map(&:to_h))
      @repository = repository
    end

    def destroy_after_1_hour
      @message = @repository.find { |x| x[:destroy_after_1_hour] == 1 }
      @current_message = MessageRepository.new.find(@message[:id])

      return unless (@current_message.created_at + 3600) < Time.now

      @current_message = MessageRepository.new.delete(@current_message.id)
    end

    def destroy_after_hours
      @message = @repository.find { |x| x[:destroy_after_hours] > 1 }
      @current_message = MessageRepository.new.find(@message[:id])
      @hour_destroy = 3600 * @current_message.destroy_after_hours

      return unless (@current_message.created_at + @hour_destroy) < Time.now

      @current_message = MessageRepository.new.delete(@current_message.id)
    end

    def destroy_after_1_visit(safelink_url)
      @message = @repository.find { |x| x[:safelink] == safelink_url }

      return unless @message

      @text_message = Interactors::EncryptAndDecryptMessage
                      .new.decrypt(@message[:text], @message[:iv])
      @current_message = MessageRepository.new.find(@message[:id])

      return unless @current_message.destroy_after_1_visit == 1

      @current_message = MessageRepository.new.delete(@current_message.id)
      @text_message
    end
  end
end
