defmodule ArgyleWerewolfWeb.ArgyleComponents do
  @moduledoc """
  Provides custom UI components without clobbering CoreComponents.
  """
  use Phoenix.Component
  use Gettext, backend: ArgyleWerewolfWeb.Gettext

  attr :items, :list
  attr :current_section, :string

  def sidebar_nav(assigns) do
    ~H"""
    <nav class="hidden">
      <ul>
        <li :for={item <- @items} class={if item.id == @current_section, do: "current"}>
          <a href={item.link}>{item.label}</a>
        </li>
      </ul>
    </nav>
    """
  end
end
