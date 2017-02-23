defmodule Reddixir.API.Requests do

    @token_url "https://www.reddit.com/api/v1/access_token"

    def headers() do
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "User-Agent": "reddixir v.01 wrapper for reddit api in elixir"
        ]
    end

    def headers(:requires_token) do
        ["Authorization": "bearer #{Reddixir.API.TokenServer.token()}"]
        |> Keyword.merge(headers())
    end

    def form,
        do: {:form, [grant_type: "client_credentials"]}

    def basic_auth,
        do: [hackney: [basic_auth: {"-400hLn5ypKJhg", "KuiYAJxYa1gqDBd4eg_Y-A3fuTw"}]]

    def build_url(endpoint),
        do: "https://oauth.reddit.com/" <> endpoint <> ".json"

     def process_response({:ok, resp}) do
        resp.body
        |> Poison.decode!(keys: :atoms)
        |> Reddixir.API.Parse.parse()
    end

    def request(method, endpoint) when method == :get do
        endpoint
        |> build_url()
        |> HTTPoison.get(headers(:requires_token))
        |> process_response()
    end

    def request(method, endpoint) when method == :post do
        endpoint
        |> build_url()
        |> HTTPoison.post(headers(:requires_token))
        |> process_response()
    end

    def request_token() do
        struct =
            @token_url
            |> HTTPoison.post(form(), headers(), basic_auth())
            |> process_response
        struct[:access_token]
    end
end