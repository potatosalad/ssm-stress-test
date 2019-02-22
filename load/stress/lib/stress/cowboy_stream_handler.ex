defmodule Stress.CowboyStreamHandler do
  @behaviour :cowboy_stream

  def init(_streamid, _req, _opts) do
    _ = spawn(:erlang, :apply, [&spinsleep/1, [5000000]])
    # _ = spawn(fn ->
    #   t1 = :erlang.monotonic_time(:microsecond)
    #   :ok = spinsleep(5000000)
    #   t2 = :erlang.monotonic_time(:microsecond)
    #   td = t2 - t1
    #   :io.format("~w ms~n", [td / 1000])
    # end)
    commands = [
      {:response, 200, %{"content-type" => "text/plain"}, "Hello world"},
      :stop
    ]
    {commands, nil}
  end

  def data(_streamid, _fin, _data, state) do
    {[], state}
  end

  def info(_streamid, _message, state) do
    {[], state}
  end

  def terminate(_streamid, _reason, _state) do
    :ok
  end

  def early_error(_streamid, _reason, _partial_req, resp, _opts) do
    resp
  end

  defp spinsleep(0) do
    :ok
  end

  defp spinsleep(n) when is_integer(n) and n > 0 do
    spinsleep(n - 1)
  end
end
