require "../spec_helper"

module GitInternalSpecs::ParsingUrl
  macro expect(url, path, scheme, host, user, port)
    it {{url}} do
      %url = Git::Url.parse({{url}})
      %url.string.should eq {{url}}
      %url.path.should eq {{path}}
      {% if scheme %}
        %url.scheme?.should eq {{scheme}}
      {% else %}
        %url.scheme?.should be_nil
      {% end %}
      {% if host %}
        %url.host?.should eq {{host}}
      {% else %}
        %url.host?.should be_nil
      {% end %}
      {% if user %}
        %url.user?.should eq {{user}}
      {% else %}
        %url.user?.should be_nil
      {% end %}
      {% if port %}
        %url.port?.should eq {{port}}
      {% else %}
        %url.port?.should be_nil
      {% end %}
    end
  end

  describe name do
    # examples from https://git-scm.com/docs/git-fetch
    expect "ssh://user@host.xz:4747/path/to/repo.git/", "/path/to/repo.git/", "ssh", "host.xz", "user", 4747
    expect "git://host.xz:4747/path/to/repo.git/", "/path/to/repo.git/", "git", "host.xz", nil, 4747
    expect "http://host.xz:4747/path/to/repo.git/", "/path/to/repo.git/", "http", "host.xz", nil, 4747
    expect "https://host.xz:4747/path/to/repo.git/", "/path/to/repo.git/", "https", "host.xz", nil, 4747
    expect "ftp://host.xz:4747/path/to/repo.git/", "/path/to/repo.git/", "ftp", "host.xz", nil, 4747
    expect "ftps://host.xz:4747/path/to/repo.git/", "/path/to/repo.git/", "ftps", "host.xz", nil, 4747
    expect "user@host.xz:path/to/repo.git/", "/path/to/repo.git/", "ssh", "host.xz", "user", nil
    expect "ssh://user@host.xz:4747/~user/path/to/repo.git/", "/path/to/repo.git/", "ssh", "host.xz", "user", 4747
    expect "git://host.xz:4747/~user/path/to/repo.git/", "/path/to/repo.git/", "git", "host.xz", "user", 4747
    expect "user@host.xz:/~user/path/to/repo.git/", "/path/to/repo.git/", "ssh", "host.xz", "user", nil
    expect "/path/to/repo.git/", "/path/to/repo.git/", nil, nil, nil, nil
    expect "file:///path/to/repo.git/", "/path/to/repo.git/", "file", nil, nil, nil
  end
end
