defmodule ArgyleWerewolfWeb.PageController do
  use ArgyleWerewolfWeb, :controller

  def home(conn, _params) do
    render(conn |> assign(:page_title, "angela quinton"), :home)
  end
end
