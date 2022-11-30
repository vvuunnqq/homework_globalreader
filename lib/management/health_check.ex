defmodule Management.HealthCheck do
  use GenServer
  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  ## Callbacks

  @impl true
  def init([url]) do
    {:ok, start(url)}
  end

  @impl true
  def handle_info(:check, state) do
    do_health_check(state.url)
    {:noreply, state}
  end

  @impl true
  def handle_cast({:set_url, url}, state) do
    {:noreply, %{state | url: url}}
  end

  def handle_cast(:start, %{status: :started} = state) do
    {:noreply, state}
  end

  def handle_cast(:start, state) do
    {:noreply, start(state.url)}
  end

  def handle_cast(:stop, %{status: :stopped} = state) do
    {:noreply, state}
  end

  def handle_cast(:stop, state) do
    :timer.cancel(state.timer)
    {:noreply, %{state| status: :stopped}}
  end

  def handle_cast(_opt, state) do
    {:noreply, state}
  end

  @impl true
  def terminate(reason, state) do
    IO.inspect({:reason, reason})
    IO.puts "Stop health check: #{inspect(state.url)}"
    :normal
  end

  defp start(url) do
    {:ok, ref} = :timer.send_interval(30000, self(), :check)
    do_health_check(url)
    %{url: url, timer: ref, status: :started}
  end

  defp do_health_check(url) do
    {t, %HTTPoison.Response{body: bo, status_code: stc}} =
      :timer.tc(fn u -> HTTPoison.get!(u) end, [url])
    case t <= 400000 do
      true ->
        %{status_code: stc, response_time: "#{div(t, 1000)}ms", body: bo}
        |> Logger.info()
      false ->
        Logger.error("Response time=#{div(t, 1000)}ms. It's higher than 400ms.")
    end
  end
end
