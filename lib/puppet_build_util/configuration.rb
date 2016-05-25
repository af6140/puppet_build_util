module PuppetBuildUtil
  class Configuration
    attr_accessor :build_prefix, :revision_prefix, :seperator
    def initialize()
      @build_prefix = 'pre'
      @revision_prefix = 'rev'
      @seperator = '-'
    end

    def to_s
      ":build_prefix=#{@build_prefix}, :revision_prefix=#{revision_prefix} , :seperator=#{seperator}"
    end
  end #class
end #module