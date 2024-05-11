module EcsRails
  class Console < Command

    def call
      puts "Executing command: #{full_command}"
      system(full_command)
    end

    private

      def full_command
        @full_command ||= "aws ecs execute-command --region #{region} --cluster #{selected_cluster} --task #{task_id} --container #{container_name} --command \'#{command}\' --interactive" 
      end


      def command
        "bundle exec rails console"
      end
  end
end
