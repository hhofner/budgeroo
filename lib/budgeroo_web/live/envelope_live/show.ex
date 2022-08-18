defmodule BudgerooWeb.EnvelopeLive.Show do
  use BudgerooWeb, :live_view

  alias Budgeroo.Budget

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:envelope, Budget.get_envelope!(id))}
  end

  defp page_title(:show), do: "Show Envelope"
  defp page_title(:edit), do: "Edit Envelope"
end
