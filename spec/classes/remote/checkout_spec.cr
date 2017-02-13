require "../../spec_helper"

module GitRemoteClassCheckoutFeature
  GitFeature.setup "#{__DIR__}/checkout"

  pending name do
    it "checkouts a remote branch into local" do
      Dir.tmp do |tmpdir|
        Dir.cd(tmpdir) do
          `git clone https://github.com/mosop/git-test.git 2>/dev/null`
          dir = "#{tmpdir}/git-test"
          Dir.cd(dir) do
            remote = Git::Repo.open(dir).remotes["origin"]
            remote.checkout("test")
            `git branch`.should eq "  master\n* test\n"
          end
        end
      end
    end

    pending "fetches and checkouts a branch into local" do
      Dir.tmp do |tmpdir|
        Dir.cd(tmpdir) do
          `git init`
          `git remote add origin https://github.com/mosop/git-test.git`
          remote = Git::Repo.open(tmpdir).remotes["origin"]
          remote.checkout("test")
          `git branch`.should eq "* test\n"
        end
      end
    end
  end
end
