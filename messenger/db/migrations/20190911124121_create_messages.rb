# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :messages do
      primary_key :id

      column :text, String, null: false
      column :safelink, String, null: false
      column :destroy_after_1_visit, Integer, default: 2
      column :destroy_after_1_hour, Integer, default: 2
      column :destroy_after_hours, Integer, default: 1
      column :iv, String, null: false
      column :password, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
