Erlang/OTP 25
Elixir 1.13.4
# Elixir homework

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Run tests: `mix test`
  * Start Phoenix endpoint inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Elixir homework 1: I Forgot Password
- Register account before using forgot password feature?
- In case keep mail config as local, please visit http://localhost:4000/dev/mailbox to check email.
Or change email config.
For example use MailJet with my api key (free 200 emails/day):

./config.exs:

    config :management, Management.Mailer, adapter: Swoosh.Adapters.Mailjet
    config :management, Management.Mailer,
    adapter: Swoosh.Adapters.Mailjet,
    api_key: "f772b91cc3524a4338ea6cda01c1cc83",
    secret: "fd046b51a7dd242fab4354db382dcc12"

    config :swoosh, :api_client, Swoosh.ApiClient.Hackney


## Elixir homework 2: Health check a endpoint every 30s
- A GenServer is: Management.HealthCheck
- It is supervised by Application's Supervisor, and it's started inside Application.
- Support:
  + Set to other url, default is https://apis.globalreader.eu/health.
  GenServer.cast(Management.HealthCheck, {:set_url, "example.org"})

  + Start/stop health check action:
  GenServer.cast(Management.HealthCheck, :start)
  GenServer.cast(Management.HealthCheck, :stop)


## Elixir homework 3: Ecto.Query
- user.ex locates in ./management/accounts/
- There are 2 tables for Devices and Jobs, can adding by web UI
- Test query by: Management.Accounts.get_user_by_email("example@gmail.com")