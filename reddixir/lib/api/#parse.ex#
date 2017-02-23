defmodule Reddixir.API.Parse do
    def parse(resp) when not is_list(resp) and not is_map(resp) do
        IO.puts("isnt a list or map")
        Poison.decode!(resp, keys: :atoms)
    end

     def parse(resp) when is_list(resp) do
         IO.puts("is a list")
        for r <- resp, do: parse(r)
    end

    def parse(resp) when is_map(resp) do
        IO.puts("recursive")
        if Map.has_key?(resp, :data) && Map.has_key?(resp.data, :children) do
            Map.update!(resp.data, :children, fn(children) ->
                Enum.map(children, fn(child) ->
                    parse(child.data)
                end)
            end)
        else
            resp
        end
    end
end