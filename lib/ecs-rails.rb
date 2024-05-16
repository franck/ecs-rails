# frozen_string_literal: true

require 'aws-sdk-ecs'

# version
require_relative 'ecs-rails/version'

# configuration
require_relative 'ecs-rails/ecs_rails_configuration'

# client
require_relative 'ecs-rails/client'

# selectors
require_relative 'ecs-rails/cluster_selector'
require_relative 'ecs-rails/service_selector'
require_relative 'ecs-rails/task_selector'

# commands
require_relative 'ecs-rails/command_executor'
require_relative 'ecs-rails/command_factory'
require_relative 'ecs-rails/command'
require_relative 'ecs-rails/console'
require_relative 'ecs-rails/bash'
require_relative 'ecs-rails/null_command'

# delegate
require 'active_support/core_ext/module/delegation'

# prompt
require "tty-prompt"

module EcsRails

  class << self
    def config
      EcsRails::EcsRailsConfiguration.instance
    end
    delegate(*EcsRails::EcsRailsConfiguration.delegated, to: :config)
  end

end
