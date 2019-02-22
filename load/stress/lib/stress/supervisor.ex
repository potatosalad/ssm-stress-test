defmodule Stress.Supervisor do
  @behaviour :supervisor

  # See http://erlang.org/doc/man/supervisor.html
  # for more information on OTP Supervisors
  def start_link() do
    :supervisor.start_link({:local, __MODULE__}, __MODULE__, [])
  end

  @impl :supervisor
  def init([]) do
    dispatch = :cowboy_router.compile([{:_, [{:_, Stress.CowboyHandler, []}]}])

    transport_options = %{
      # connection_type: :supervisor,
      # num_acceptors: 100,
      socket_opts: [port: 50051]
    }

    protocol_options = %{
      # connection_type: :supervisor,
      env: %{dispatch: dispatch},
      stream_handlers: [Stress.CowboyStreamHandler]
    }

    child_specs = [
      :ranch.child_spec(Stress.CowboyHandler.HTTP, :ranch_tcp, transport_options, :cowboy_clear, protocol_options)
    ]

    sup_flags = %{
      strategy: :one_for_one,
      intensity: 1,
      period: 5
    }

    {:ok, {sup_flags, child_specs}}
  end
end
