require 'json'
module PuppetBuildUtil

  class ModuleMetaData
    attr_reader :metadata, :config

    def initialize(meta_json, config=Configuration.new)
      File.open(meta_json, 'r') do |f|
        content=f.read
        @metadata=JSON.parse(content)
      end
      @config = config
    end

    def write(meta_json)
      File.open(meta_json, 'w') do |f|
        f.write(JSON.pretty_generate(@metadata)) if @metadata
      end
    end

    def version
      @metadata['version']
    end

    def version=(v)
      @metadata['version'] = v
    end

    def bump(part)
      v_specs=retrieve_version
      case part
      when 'major'
        v_specs[0]="#{v_specs[0].to_i+1}"
      when 'minor'
        v_specs[1]="#{v_specs[1].to_i+1}"
      when 'patch'
        v_specs[2]="#{v_specs[2].to_i+1}"
      else
        #defult to patch
        v_specs[2]="#{v_specs[2].to_i+1}"
      end

      version_spec= v_specs[0..2].join('.')
      new_version="#{version_spec}-#{v_specs[3]}"
      @metadata['version'] = new_version
    end

    # generate release information
    def gen_pre_release_info(build_number, revision)
      "#{@config.build_prefix}#{build_number}#{@config.seperator}#{@config.revision_prefix}#{revision}"
    end

    def retrieve_version()
      v_specs=@metadata['version'].split('-', 2)
      version_part=v_specs[0]
      release_part=v_specs[1]
      version_specs=version_part.split('.')
      version_specs << release_part if release_part
      version_specs
    end

    def to_s
      @metadata.to_s unless @metadata
    end

  end # class
end #module