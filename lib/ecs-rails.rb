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


# prompt
require "tty-prompt"

module EcsRails

  @configuration = EcsRails::EcsRailsConfiguration.setup

  class << self
    extend Forwardable

    def_delegators :@configuration, :aws_region, :aws_region=
    def_delegators :@configuration, :aws_access_key_id, :aws_access_key_id=
    def_delegators :@configuration, :aws_secret_access_key, :aws_secret_access_key=
    def_delegators :@configuration, :container_name, :container_name=
  end

end
