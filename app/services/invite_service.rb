class InviteService

  def initialize(handle, token)
    @handle = handle
    @token = token
  end

  def get_json
    json("/users/#{@handle}")
  end

  private

  def json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = @token
      faraday.adapter Faraday.default_adapter
    end
  end
end
