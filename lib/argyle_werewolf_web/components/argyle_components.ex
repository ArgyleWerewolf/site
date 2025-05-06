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

  def navigation(assigns) do
    ~H"""
    <nav id="up">
      <h2>Angela Quinton</h2>
      <ul class="hidden">
        <li :for={item <- @items} class={if item.id == @current_section, do: "current"}>
          <a href={item.link}>{item.label}</a>
        </li>
      </ul>
    </nav>
    """
  end

  attr :current_section, :string
  attr :back_link, :string

  def colophon(assigns) do
    ~H"""
    <div id="colophon">
      <.back_link :if={@back_link} to={@back_link} />
      <.back_link to="#up" text="↑" label={gettext("Back to the top")} />
    </div>
    """
  end

  attr :to, :string, default: "/"
  attr :text, :string, default: "← Back"
  attr :label, :string, default: nil

  def back_link(assigns) do
    ~H"""
    <a href={@to} aria-label={@label} class="in-page-nav">{@text}</a>
    """
  end

  def stickers(assigns) do
    ~H"""
    <div class="sticker-sheet">
      <div class="sticker one">
        <p>Excuse the mess</p>
        <span class="fold"></span>
      </div>
      <div class="sticker two">
        <p>
          I was laid off in late April <span>&amp;</span>
          am updating this site to reflect my work <span>&amp;</span>
          capabilities
        </p>
      </div>
      <div class="sticker three">
        <p>
          <strong>Last update:</strong> 2025-05-06, 12:16 EDT
        </p>
      </div>
    </div>
    """
  end
end
