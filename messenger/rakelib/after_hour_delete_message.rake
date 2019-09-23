# frozen_string_literal: true

require 'pry'
namespace :messenger do
  desc 'Delete records after one hour'
  task delete_message: :environment do
    Interactors::DeleteMessage.new.destroy_after_1_hour
  end
end
