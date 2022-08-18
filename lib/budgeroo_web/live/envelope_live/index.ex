defmodule BudgerooWeb.EnvelopeLive.Index do
  use BudgerooWeb, :live_view

  alias Budgeroo.Budget
  alias Budgeroo.Budget.Envelope

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :envelopes, list_envelopes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :add, %{"id" => id}) do
      socket
      |> assign(:page_title, "Add to Envelope")
      |> assign(:envelope, Budget.get_envelope!(id))
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Envelope")
    |> assign(:envelope, Budget.get_envelope!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Envelope")
    |> assign(:envelope, %Envelope{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Envelopes")
    |> assign(:envelope, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    envelope = Budget.get_envelope!(id)
    {:ok, _} = Budget.delete_envelope(envelope)

    {:noreply, assign(socket, :envelopes, list_envelopes())}
  end

  defp list_envelopes do
    Budget.list_envelopes()
  end
end
