require "../submodules/crystal_lib/src/clang"
require "../submodules/crystal_lib/src/crystal_lib"

node = Crystal::Parser.parse(<<-EOS
module Git
  @[Include(
    "#{ARGV[0]}/git2.h",
    "#{ARGV[0]}/git2/global.h",
    prefix: %w(git_ GIT_ Git))]
  {% if flag?(:crystal_git_static) %}
    @[Link(static: true, ldflags: {{ env("CRYSTAL_GIT_LDFLAGS") || ""}})]
  {% else %}
    @[Link("git2", ldflags: {{ env("CRYSTAL_GIT_LDFLAGS") || "" }})]
  {% end %}
  lib C
  end
end
EOS
)
visitor = CrystalLib::LibTransformer.new
transformed = node.transform visitor
File.write("#{__DIR__}/../../src/lib/c/auto_generated.cr", transformed)
