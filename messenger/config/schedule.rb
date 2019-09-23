# frozen_string_literal: true

every 1.minute do
  rake 'messenger:delete_message'
end
every 10.minute do
  rake 'messenger:delete_message_after_hours'
end
