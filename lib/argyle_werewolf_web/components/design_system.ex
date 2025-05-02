defmodule ArgyleWerewolfWeb.DesignSystem do
  def sprite(assigns) do
    apply(PhoenixSvgSprites.Sprite, :sprite, [assigns])
  end
end
