require 'spec_helper'

describe PuppetBuildUtil do
  let(:meta_json) { File.expand_path('../fixtures/metadata.json', __FILE__)}
  subject {PuppetBuildUtil::ModuleMetaData.new(meta_json)}

  describe '#update_module_version' do
    let(:build_number) {10}
    let(:revision_hash) { 'abc1234'}

    it 'bump module version' do
      release_info=subject.gen_pre_release_info(build_number, revision_hash)
      version_specs=subject.retrieve_version
      if version_specs.length > 3
        raise  "Version already has release info: #{version_specs}"
      end
      #update info
      new_version = "#{subject.version}-#{release_info}"
      puts "Version with release info : #{new_version}"
      expect(release_info).to match /pre100010-revabc1234/
      subject.version=new_version
      #bump patch level
      subject.bump('patch')
      expect(subject.version).to match /0[[:punct:]]1[[:punct:]]1/

    end
  end
end
