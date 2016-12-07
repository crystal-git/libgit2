require "../submodules/crystal_lib/src/clang"
require "../submodules/crystal_lib/src/crystal_lib"

node = Crystal::Parser.parse(<<-EOS
module Git
  @[Include(
    "git2.h",
    prefix: %w(git_ GIT_ Git))]
  {% if flag?(:travis) %}
    @[Link(ldflags: {{ env("CRYSTAL_GIT_LDFLAGS") }})]
    @[Link("libgit2")]
  {% else %}
    @[Link("git2")]
  {% end %}
  lib C
  end
end
EOS
)
visitor = CrystalLib::LibTransformer.new
transformed = node.transform visitor
File.write("#{__DIR__}/../../src/lib/c/auto_generated.cr", transformed)
