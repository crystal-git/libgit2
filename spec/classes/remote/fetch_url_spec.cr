require "../../spec_helper"

module GitRemoteClassFetchUrlFeature
  GitFeature.setup "#{__DIR__}/fetch_url"

  it name do
    Dir.tmp do |tmpdir|
      Dir.cd(tmpdir) do
        `git init`
        `git remote add origin https://github.com/mosop/fetch.git`
        `git remote set-url --push origin https://github.com/mosop/push.git`
        remote = Git::Dir.new(tmpdir).repo.remotes["origin"]
        remote.fetch_url.string.should eq "https://github.com/mosop/fetch.git"
        remote.push_url.string.should eq "https://github.com/mosop/push.git"
      end
    end
  end
end
