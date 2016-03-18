defmodule PlugRuntime.Mixfile do
  use Mix.Project

  @description """
    A simple Plug to measure the runtime of a request. Results will be in the
    X-Runtime header.
  """

  def project do
    [app: :plug_runtime,
     version: "1.0.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: @description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:plug]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:plug, "~> 1.0"}]
  end

  defp package do
    [ maintainers: ["Mike Evans"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/mje113/plug_runtime",
              "Docs" => "http://mje113.github.io/plug_runtime/"}]
  end
end
