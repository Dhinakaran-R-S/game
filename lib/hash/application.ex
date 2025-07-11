defmodule Hash.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HashWeb.Telemetry,
      Hash.Repo,
      {DNSCluster, query: Application.get_env(:hash, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hash.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hash.Finch},
      # Start a worker by calling: Hash.Worker.start_link(arg)
      # {Hash.Worker, arg},
      # Start to serve requests, typically the last entry
      HashWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HashWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
