# frozen_string_literal: true

module RSpec
  module FeatureExampleGroup
    def self.included(group)
      group.metadata[:type] = :feature
      Capybara.app = Hanami.app
      Capybara.server = :webrick
    end
  end
end
