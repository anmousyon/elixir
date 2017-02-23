defmodule Reddixir.API.TokenServer do
    use GenServer

    alias Reddixir.API.Requests

    @token_server __MODULE__
    @token_interval 59 * 60 * 1000

    def start_link do
        GenServer.start_link(@token_server, [], name: @token_server)
    end

    def init(_) do
        token_state = Requests.request_token()
        start_token_wait()
        {:ok, token_state}
    end

    def get_token do
        send(@token_server, :new_token)
    end

    def token do 
        GenServer.call(@token_server, :token)
    end

    #Callbacks

    def handle_call(:token, _from, token_state) do
        {:reply, token_state, token_state}
    end

    def handle_info(:new_token, _token_state) do
        token_state = Requests.request_token()
        start_token_wait()
        {:noreply, token_state}
    end

    defp start_token_wait do
        Process.send_after(@token_server, :new_token, @token_interval)
    end
end