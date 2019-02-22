defmodule Stress.CowboyHandler do
  @behaviour :cowboy_handler

  @impl :cowboy_handler
  def init(req, opts) do
    # _ = spawn(:erlang, :apply, [&spinsleep/1, [5000000]])
    # :ok = spinsleep(1000000)
    # receive do
    # after
    #   1000 ->
    #     :ok
    # end
    req =
      :cowboy_req.reply(200, %{
        "content-type" => "text/plain"
      }, "Hello world", req)
    {:ok, req, opts}
  end

  defp spinsleep(0) do
    :ok
  end

  defp spinsleep(n) when is_integer(n) and n > 0 do
    spinsleep(n - 1)
  end
end
