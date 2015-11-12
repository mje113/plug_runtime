defmodule Plug.Runtime do
  import Plug.Conn
  @behaviour Plug

  def init(opts) do
    Keyword.get(opts, :http_header, "x-runtime")
  end

  def call(conn, _opts) do
    before_time = timestamp

    conn
    |> register_before_send( &set_runtime_header(&1, before_time) )
  end

  defp set_runtime_header(conn, before_time) do
    after_time = timestamp
    diff = :timer.now_diff(after_time, before_time)

    conn
    |> put_resp_header("x-runtime", formatted_diff(diff))
  end

  defp timestamp do
    :os.timestamp
  end

  defp formatted_diff(diff) when diff > 1000 do
    "#{Integer.to_string(diff |> div(1000))}ms"
  end

  defp formatted_diff(diff) do
    "#{Integer.to_string(diff)}µs"
  end
end
