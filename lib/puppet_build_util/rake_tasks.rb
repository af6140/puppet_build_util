require 'rake'
require 'rake/tasklib'
require 'puppet_build_util'
require 'rubygems'

module PuppetBuildUtil
  class RakeTask < ::Rake::TaskLib

    def initialize(*args, &task_block)
      @task_name = args.shift || "mgit_util"
      @desc = args.shift || "Multiple Git Repo Utilities"
      define(args, &task_block)
    end

    def define(args, &task_block)
      task_block.call(*[self, args].slice(0, task_block.arity)) if task_block
      [
        :dump_last_commit_info
      ].each do |t|
        Rake::Task.task_defined?("puppet_build_util:#{t}") && Rake::Task["puppet_build_util:#{t}"].clear
      end

      namespace :puppet_build_util do      
        desc "update metadata.json version with build info and revision info"
        task :set_build_version, [:noop, :build_number, :revision] do |t , args|
          current_dir = ENV['cwd'] || Dir.pwd
          metadata_json = File.expand_path('metadata.json', current_dir)
          fail "Cannot find #{metadata_json}" unless File.exists?(metadata_json)
          metadata=PuppetBuildUtil::ModuleMetadata(metadata_json)
          if args[:noop] && 'false' == args[:noop]
            if args[:build_number] && !args[:build_number].empty? && args[:revision] && !args[:revision].empty?
              puts "Current version is #{metadata.version}"
              release_info=rev_metadata.gen_release_info(args[:build_number], args[:revision])
              version_specs=metadata.retrieve_version
              if version_specs.length > 3
                fail "Version already has release info"
              end
              #update info
              new_version = "#{metadata.version}-#{release_info}"              
              metadata.version new_version
              #bump patch level
              metadata.bump('patch')
              puts "Setting version to #{metadata.version}"
              metadata.write metadata_json
            end
          end
          
        end #task
       end #namespace
      end #method define
  end # class
    
end # module