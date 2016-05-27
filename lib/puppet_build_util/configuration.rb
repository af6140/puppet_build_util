module PuppetBuildUtil
  class Configuration
    attr_accessor :build_prefix, :revision_prefix, :seperator, :padding_scale
    def initialize()
      @build_prefix = 'pre'
      @revision_prefix = 'rev'
      @seperator = '-'
      #the prerelease build number will be build_number+10*@padding_scale
      # so it sorted lexically in correct order
      @padding_scale=10000 
    end

    def to_s
      ":build_prefix=#{@build_prefix}, :revision_prefix=#{@revision_prefix} , :seperator=#{@seperator}, :padding_scale=#{@padding_scale}"
    end
  end #class
end #module