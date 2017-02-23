defmodule Reddixir.API.Post do
    alias Reddixir.API.Requests

    def comments(subreddit, post) do
        endpoint = "r/#{subreddit}/comments/#{post}"
        Requests.request(:get, endpoint)
    end

end