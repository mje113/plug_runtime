defmodule Plug.RuntimeTest do
  use ExUnit.Case, async: true
  use Plug.Test

  defmodule MyPlug do
    use Plug.Router

    plug Plug.Runtime
    plug :match
    plug :dispatch

    get "/hello" do
      conn |> hello
    end

    get "/slow_hello" do
      :timer.sleep(1_000)
      conn |> hello
    end

    defp hello(conn) do
      send_resp(conn, 200, "hello")
    end
  end

  defp call(conn) do
    MyPlug.call(conn, [])
  end

  test "adds X-Runtime header" do
    conn = conn(:get, "/hello") |> call()
    [res_runtime] = conn |> get_resp_header("x-runtime")
    assert res_runtime != nil
  end

  test "adds X-Runtime header for slow request" do
    conn = conn(:get, "/slow_hello") |> call()
    [res_runtime] = conn |> get_resp_header("x-runtime")
    assert Regex.match?(~r/(\d*)ms/, res_runtime)
  end
end
