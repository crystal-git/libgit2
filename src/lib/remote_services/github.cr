module Git::RemoteServices
  class Github < Base
    class PullRequest
      @json : Hash(String, JSON::Type)

      def initialize(@json)
        puts number
      end

      @number : Int64?
      def number
        @number ||= @json["number"].as(Int64)
      end
    end

    @@pool = {} of String => Github
    def self.pool
      @@pool
    end

    def self.register(workspace, owner, repo)
      o = new(workspace, owner, repo)
      pool[o.key] ||= o
    end

    @key : String?
    def key
      @key ||= "#{owner}:#{repo}"
    end

    getter pull_requests = {} of String => Hash(Int64, PullRequest)

    def pull_requests_for(head)
      pull_requests[head]? || (pull_requests[head] = fetch_pull_requests_for(head))
    end

    REDIRECT_CODES = [301, 302, 307]

    def fetch_pull_requests_for(head)
      api_get("/repos/#{owner}/#{repo}/pulls?head=#{URI.escape("#{owner}:#{head}")}") do |url, response|
        loop do
          break if response.success?
          raise HttpError.new(url, response) unless REDIRECT_CODES.includes?(response.status_code)
          response = HTTP::Client.get(response.headers["Location"])
        end
        raise Rescuable.new("Pagenation is not implemented.") if response.headers["Link"]?.to_s.size > 0
        ({} of Int64 => PullRequest).tap do |h|
          JSON.parse(response.body_io.gets_to_end).as_a.each do |json|
            pr = PullRequest.new(json.as(Hash(String, JSON::Type)))
            h[pr.number] = pr
          end
        end
      end
    end

    def api_url(path)
      "https://api.github.com#{path}"
    end

    @api_headers : HTTP::Headers?
    def api_headers
      @api_headers ||= HTTP::Headers.new.tap do |h|
        h["Accept"] = "application/vnd.github.v3+json"
        h["User-Agent"] = "mosop/git"
        h["Authorization"] = "token #{access_token}"
      end
    end

    def api_get(path)
      url = api_url(path)
      HTTP::Client.get(url, api_headers) do |response|
        yield url, response
      end
    end
  end
end
