# LiveReload

Live reloading for Elixir projects.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add live_reload to your list of dependencies in `mix.exs`:

        defp deps do
          [{:live_reload, git: "https://github.com/termoose/live-reload"}]
        end

  2. Ensure live_reload is started before your application:

        def application do
          [applications: [:live_reload]]
        end

