defmodule ArgyleWerewolfWeb.WerewolvesVersusController do
  use ArgyleWerewolfWeb, :controller

  @target_domain "https://werewolf.pizza"

  def bounce(conn, %{"path" => path}) do
    path = Enum.join(path, "/")
    redirect_url = Path.join([@target_domain, "werewolves-versus", path])

    conn
    |> put_status(301)
    |> redirect(external: redirect_url)
  end
end
