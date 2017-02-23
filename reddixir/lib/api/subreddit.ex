defmodule Reddixir.API.Subreddit do
    def get_posts(res) do
        res[:children]
    end

    def build_endpoint({subreddit, sort}) do
        "r/#{subreddit}/#{sort}"
    end

    def make_request(endpoint) do
        Reddixir.API.Requests.request(:get, endpoint)
    end

    def posts({subreddit, sort}) do
        {subreddit, sort}
        |> build_endpoint()
        |> make_request()
        |> get)posts()
    end
end