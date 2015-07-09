defmodule YifySubtitle.Mixfile do
  use Mix.Project

  def project do
    [app: :yify_subtitle,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      applications: [:httpoison, :logger, :poison],
      env: [adapter: YifySubtitle.Adapters.API]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.6"},
      {:mock,      "~> 0.1.0", only: :test},
      {:poison,    "~> 1.4.0"}
    ]
  end
end
