defmodule CodeMySpecWeb.AppLive do
  defmacro __using__(_opts) do
    quote do
      use CodeMySpecWeb, :live_view
    end
  end
end

