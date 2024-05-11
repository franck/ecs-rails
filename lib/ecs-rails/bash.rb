module EcsRails
  class Bash < Command

    def call
      return full_command if test_mode?

      puts "Executing command: #{full_command}"
      system(full_command)
    end

    private

      def full_command
        @full_command ||= "aws ecs execute-command --region #{region} --cluster #{selected_cluster} --task #{task_id} --container #{container_name} --command \'#{command}\' --interactive" 
      end


      def command
        "bash"
      end
  end
end
