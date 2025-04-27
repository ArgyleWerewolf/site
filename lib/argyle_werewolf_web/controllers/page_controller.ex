defmodule ArgyleWerewolfWeb.PageController do
  use ArgyleWerewolfWeb, :controller
  plug :put_template_class

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

  defp put_template_class(conn, _) do
    template =
      conn
      |> Phoenix.Controller.action_name()
      |> Atom.to_string()

    assign(conn, :template_class, template)
  end
end
