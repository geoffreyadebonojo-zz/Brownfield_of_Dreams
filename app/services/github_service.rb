class GithubService

  def initialize(token)
    @key = token
  end

  def followers
    get_followers_json
  end

  def repos
    get_repos_json
  end

  private

  def get_followers_json
    @followers_response ||= conn.get("/user/followers")
    @followers_parsed ||= JSON.parse(@followers_response.body, symbolize_names: true)
  end

  def get_repos_json
    @repo_response ||= conn.get("/user/repos")
    @repo_parsed ||= JSON.parse(@repo_response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => 'https://api.github.com') do |f|
      f.headers['Authorization'] = @key
      f.adapter Faraday.default_adapter
    end
  end
end
