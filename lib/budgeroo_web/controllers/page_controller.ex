defmodule BudgerooWeb.PageController do
  use BudgerooWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
