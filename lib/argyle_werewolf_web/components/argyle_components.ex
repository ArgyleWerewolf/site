defmodule ArgyleWerewolfWeb.ArgyleComponents do
  @moduledoc """
  Provides custom UI components without clobbering CoreComponents.
  """
  use Phoenix.Component
  use Gettext, backend: ArgyleWerewolfWeb.Gettext
  import ArgyleWerewolfWeb.DesignSystem

  attr :show_themes, :boolean, default: false
  attr :show_mode, :boolean, default: false

  def ui_controls(assigns) do
    ~H"""
    <div id="ui-controls">
      <div :if={@show_themes} class="themes">
        <button class="theme-switch" id="default">1</button>
        <button class="theme-switch" id="assert">2</button>
      </div>
      <button :if={@show_mode} id="mode-switch" aria-label={gettext("Light / Dark mode toggle")}>
        <.sprite icon="full-moon" class="svg-sprite moon" title={gettext("The moon")} />
        <.sprite icon="sun" class="svg-sprite sun" title={gettext("The sun")} />
      </button>
    </div>
    """
  end

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

  attr :to, :string, default: "/"
  attr :text, :string, default: "← back"

  def back_link(assigns) do
    ~H"""
    <a href={@to} class="in-page-nav">{@text}</a>
    """
  end
end
