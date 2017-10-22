require "spec"
require "crystal_plus/dir/.tmp"
require "../src/libgit2"

module GitFeature
  macro setup(dir)
    DIR = {{dir}}
    CURRENT = "#{DIR}/current"
  end
end
