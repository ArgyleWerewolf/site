defmodule ArgyleWerewolfWeb.DesignSystem do
  @moduledoc """
  Referene and apply / defdelegate externally-sourced components.
  """

  def sprite(assigns) do
    apply(PhoenixSvgSprites.Sprite, :sprite, [assigns])
  end
end
