module Git
  class Url
    class Invalid < Git::Exception
      def initialize(s)
        super "Invalid Git URL: #{s}"
      end
    end

    getter string : String
    getter! host : String?
    getter path : String
    getter? local : Bool

    def initialize(@string, @host, @path, @local)
      if host = @host
        raise Invalid.new(@string) if host.empty?
      else
        raise Invalid.new(@string) unless @local
      end
      raise Invalid.new(@string) if @path.empty?
    end

    URI_PATTERN = /^(\w+):\/\//
    SCP_LIKE_PATTERN = /^[^\/]+:./

    def self.parse(s)
      if s.starts_with?("/") || s.starts_with?(".")
        new(s, nil, s, true)
      elsif s.starts_with?("file://")
        new(s, nil, s["file://".size..-1], true)
      elsif URI_PATTERN =~ s
        case $1
        when "ssh", "git"
          uri = URI.parse(s)
          parse_user_extension(s, uri.host, uri.path.to_s)
        else
          uri = URI.parse(s)
          new(s, uri.host, uri.path.to_s, false)
        end
      elsif SCP_LIKE_PATTERN =~ s
        a = s.split(":")
        host = a[0].includes?("@") ? a[0].split("@")[1..-1].join("@") : a[0]
        path = a[1..-1].join(":")
        path = "/#{path}" if !path.starts_with?("/")
        parse_user_extension(s, host, path)
      else
        raise Invalid.new(s)
      end
    end

    def self.parse_user_extension(s, host, path)
      a = path.split("/")
      if a[1]? && a[1].starts_with?("~")
        a.shift
        a.shift
        a.unshift ""
      end
      new(s, host, a.join("/"), false)
    end
  end
end
