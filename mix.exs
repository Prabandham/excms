defmodule ExCms.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_cms,
      version: "0.0.8",
      elixir: "~> 1.6.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ExCms.Application, []},
      extra_applications: [:logger, :runtime_tools, :liquid, :con_cache, :scrivener_ecto, :scrivener_html]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0", override: true},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:earmark, "~> 1.2"},
      {:liquid, "~> 0.8.0"},
      {:con_cache, "~> 0.12.1"},
      {:comeonin, "~> 4.0"},
      {:argon2_elixir, "~> 1.2"},
      {:scrivener_ecto, "~> 1.0"},
      {:scrivener_html, "~> 1.7"},
      {:scrivener_list, "~> 1.0"},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:ex_aws, "~> 1.0"},
      {:poison, "~> 2.0"},
      {:hackney, "~> 1.6"},
      {:uuid, "~> 1.1" },
      {:edeliver, "~> 1.4.2"},
      {:distillery, "~> 1.4"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
