class UserDashboardFacade
  def initialize(user)
    @user = user
    @key = "token #{@user.api_keys.first.key}"
  end

  def repo_obj
    get_json.map do |h|
      Repo.new(h)
    end[0..4]
  end

  private

  def get_json
    @response ||= conn.get("/user/repos")
    @parsed ||= JSON.parse(@response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => 'https://api.github.com') do |f|
      f.headers['Authorization'] = @key
      f.adapter Faraday.default_adapter
    end
  end
end
