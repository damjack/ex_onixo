defmodule ExOnixo.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_onixo,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/damjack/ex_onixo",
      docs: [extras: ["README.md"], main: "ExOnixo"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:sweet_xml, "~> 0.6.5"},
      {:html_entities, "~> 0.4.0"},
      {:yaml_elixir, "~> 1.3.1"},
      {:timex, "~> 3.1"}
    ]
  end
end
