module Git
  struct Url
    getter string : String
    getter path : String
    getter? scheme : String?
    getter? host : String?
    getter? user : String?
    getter? port : Int32?

    def initialize(@string, @path, @scheme, @host, @user, @port)
    end

    URL_PATTERN = /^\w+:\/\//
    SCP_LIKE_PATTERN = /^[^\/]+:/

    def self.parse(s)
      if s.starts_with?("/") || s.starts_with?(".")
        parse_local_path(s)
      elsif URL_PATTERN =~ s
        parse_url(s)
      elsif SCP_LIKE_PATTERN =~ s
        parse_scp_like(s)
      else
        raise InvalidUrl.new(s)
      end
    end

    def self.parse_local_path(s)
      Url.new(string: s, path: s, scheme: nil, host: nil, user: nil, port: nil)
    end

    def self.parse_url(s)
      uri = URI.parse(s)
      case uri.scheme
      when "ssh", "git"
        parse_url_with_username_expansion(s, uri)
      else
        parse_url_without_username_expansion(s, uri)
      end
    end

    def self.parse_url_with_username_expansion(s, uri)
      a = uri.path.to_s.split("/")
      user = if a[1]? && a[1].starts_with?("~")
        a.shift
        u = a.shift
        a.unshift ""
        u[1..-1]
      else
        uri.user
      end
      Url.new(string: s, path: a.join("/"), scheme: uri.scheme, host: uri.host, user: user, port: uri.port)
    end

    def self.parse_url_without_username_expansion(s, uri)
      Url.new(string: s, path: uri.path.to_s, scheme: uri.scheme, host: uri.host, user: uri.user, port: uri.port)
    end

    def self.parse_scp_like(s)
      parse_url_with_username_expansion(s, URI.parse("ssh://" + s.split(":").join("/").sub("//", "/")))
    end
  end
end
