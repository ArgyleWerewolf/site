defmodule ArgyleWerewolfWeb.PageController do
  use ArgyleWerewolfWeb, :controller
  plug :put_current_section
  plug :put_nav_items

  def home(conn, _params) do
    render(conn |> assign(:page_title, "Angela Quinton"), :home)
  end

  def code(conn, _params) do
    render(conn |> assign(:page_title, "Code"), :code)
  end

  def sprites(conn, _params) do
    render(conn |> assign(:page_title, "Sprites"), :sprites)
  end

  def writing(conn, _params) do
    render(conn |> assign(:page_title, "Writing"), :writing)
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

  def design(conn, _params) do
    render(conn |> assign(:page_title, "Design"), :design)
  end

  def about(conn, _params) do
    render(conn |> assign(:page_title, "About"), :about)
  end

  defp put_current_section(conn, _) do
    template =
      conn
      |> Phoenix.Controller.action_name()
      |> Atom.to_string()

    assign(conn, :current_section, template)
  end

  defp put_nav_items(conn, _) do
    items = [
      %{id: "home", label: gettext("Home"), link: ~p"/"},
      %{id: "code", label: gettext("Code"), link: ~p"/code/"},
      %{id: "writing", label: gettext("Writing"), link: ~p"/writing/"},
      %{id: "design", label: gettext("Design"), link: ~p"/design/"},
      %{id: "accolades", label: gettext("About"), link: ~p"/about/"}
    ]

    assign(conn, :nav_items, items)
  end
end
