require "../../spec_helper"

module GitRemoteClassCheckoutFeature
  GitFeature.setup "#{__DIR__}/checkout"

  describe name do
    it "checkouts a remote branch into local" do
      Dir.tmp do |tmpdir|
        Dir.cd(tmpdir) do
          `git clone https://github.com/mosop/git-test.git 2>/dev/null`
          dir = "#{tmpdir}/git-test"
          Dir.cd(dir) do
            remote = Git::Repo.new(dir).remotes["origin"]
            remote.checkout("test")
            `git branch`.should eq "  master\n* test\n"
          end
        end
      end
    end

    it "fetches and checkouts a branch into local" do
      Dir.tmp do |tmpdir|
        Dir.cd(tmpdir) do
          `git init`
          `git remote add origin https://github.com/mosop/git-test.git`
          remote = Git::Repo.new(tmpdir).remotes["origin"]
          remote.checkout("test")
          `git branch`.should eq "* test\n"
        end
      end
    end
  end
end
