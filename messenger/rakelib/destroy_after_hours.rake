# frozen_string_literal: true

require 'pry'
namespace :messenger do
  desc 'Delete records after one hour'
  task delete_message_after_hours: :environment do
    Interactors::DeleteMessage.new.destroy_after_hours
  end
end
