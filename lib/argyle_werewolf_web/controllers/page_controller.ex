defmodule ArgyleWerewolfWeb.PageController do
  use ArgyleWerewolfWeb, :controller

  def home(conn, _params) do
    render(conn |> assign(:page_title, "Angela Quinton"), :home)
  end

  def ltq(conn, _params) do
    render(
      conn
      |> assign(
        :page_title,
        "Symbolism of Lycanthropy In Horror Media - Angela Quinton answers questions from Miranda Lascelles"
      ),
      :ltq
    )
  end
end
