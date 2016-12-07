require "./src/git"

dir = Git::Dir.new(__DIR__)
remote = dir.repo.remotes["origin"]
puts "fetch: #{remote.fetch_url.host} #{remote.fetch_url.path}, push: #{remote.push_url?}"
